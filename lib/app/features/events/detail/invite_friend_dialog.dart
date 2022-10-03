import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/invite_friend_request.dart';
import 'package:audio_cult/app/data_source/models/responses/event_invitation/event_invitation_response.dart';
import 'package:audio_cult/app/features/events/detail/invite_friend_bloc.dart';
import 'package:audio_cult/app/features/events/detail/invite_friend_checked_item.dart';
import 'package:audio_cult/app/features/events/detail/invite_friend_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../data_source/models/requests/get_invitation_request.dart';
import '../../../utils/toast/toast_utils.dart';

class InviteFriendDialog extends StatefulWidget {
  const InviteFriendDialog({
    Key? key,
    this.eventId,
    this.bloc,
    this.users,
  }) : super(key: key);

  final int? eventId;
  final InviteFriendBloc? bloc;
  final List<EventInvitationResponse>? users;

  @override
  State<InviteFriendDialog> createState() => _InviteFriendDialogState();
}

class _InviteFriendDialogState extends State<InviteFriendDialog> {
  final _request = InviteFriendRequest();
  var _originalUsers = <EventInvitationResponse>[];
  var _checkedUsers = <EventInvitationResponse>[];
  var _apiUsers = <EventInvitationResponse>[];

  @override
  void initState() {
    super.initState();
    _initData();
    widget.bloc?.inviteFriendStream.listen((event) {
      ToastUtility.showSuccess(context: context, message: context.localize.t_invite_friend_success);
      Navigator.pop(context);
      widget.bloc?.getInvitation(GetInvitationRequest(
        itemId: widget.eventId,
        searchType: 'event',
        keyword: '',
      ));
    });
  }

  void _initData() {
    _apiUsers = widget.users!;
    _originalUsers = _apiUsers;
    _checkedUsers = widget.users!;
  }

  void _runFilter(String keyword) {
    var results = <EventInvitationResponse>[];
    if (keyword.isEmpty) {
      results = _apiUsers;
    } else {
      results = _apiUsers
          .where((user) =>
              user.fullName!.toLowerCase().contains(keyword.toLowerCase()) ||
              user.email!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _originalUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: widget.bloc!,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.mainColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInviteFriend(),
                  const SizedBox(height: 12),
                  _buildSearch(),
                  const SizedBox(height: 12),
                  _buildListUser(),
                  const SizedBox(height: 12),
                  _buildUnselectedAll(),
                  const SizedBox(height: 12),
                  _buildInputMail(),
                  const SizedBox(height: 12),
                  _buildPersonalMessage(),
                  const SizedBox(height: 18),
                  _buildSubmitButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendRequest() {
    final sb = StringBuffer();
    for (final item in _checkedUsers) {
      sb.write('${item.userId},');
    }

    _request.type = 'event';
    _request.itemId = widget.eventId.toString();
    _request.userIds = sb.toString();
    widget.bloc?.inviteFriends(_request);
  }

  Widget _buildSubmitButton() {
    return CommonButton(
      color: AppColors.primaryButtonColor,
      text: context.localize.t_submit_button,
      onTap: _checkedUsers
                  .firstWhere((element) => element.isChecked == true, orElse: EventInvitationResponse.new)
                  .isChecked ==
              true
          ? _sendRequest
          : null,
    );
  }

  Widget _buildSearch() {
    return CommonInput(
      hintText: context.localize.t_search_email,
      onChanged: _runFilter,
    );
  }

  Widget _buildInviteFriend() {
    return Text(
      context.localize.t_invite_friend,
      style: context.bodyTextPrimaryStyle()!.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
    );
  }

  Widget _buildPersonalMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localize.t_add_personal_message,
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 8),
        CommonInput(
          maxLine: 3,
          onChanged: (value) {
            _request.personalMessage = value;
          },
        ),
      ],
    );
  }

  Widget _buildInputMail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localize.t_invite_friend_mail,
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 8),
        CommonInput(
          maxLine: 3,
          hintText: context.localize.t_seperate_email,
          onChanged: (value) {
            _request.emails = value;
          },
        ),
      ],
    );
  }

  Widget _buildUnselectedAll() {
    return Visibility(
      visible: _checkedUsers.where((element) => element.isChecked == true).toList().isNotEmpty,
      child: WButtonInkwell(
        onPressed: () {
          for (final element in _checkedUsers) {
            setState(() {
              element.isChecked = false;
            });
          }
        },
        child: Text(
          '${context.localize.t_deselected_all} (${_checkedUsers.where((element) => element.isChecked == true).toList().length})',
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: AppColors.activeLabelItem,
                fontSize: 16,
              ),
        ),
      ),
    );
  }

  Widget _buildListUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_originalUsers.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _originalUsers
                .map(
                  (e) => InviteFriendItem(
                    data: e,
                    onChecked: (data, isChecked) {
                      setState(() {
                        e.isChecked = isChecked;
                        for (var i = 0; i < _checkedUsers.length; i++) {
                          if (_checkedUsers[i].userId == e.userId) {
                            _checkedUsers[i].isChecked = isChecked;
                          }
                        }
                      });
                    },
                  ),
                )
                .toList(),
          )
        else
          Text(
            context.localize.t_no_data,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            for (var i = 0; i < _checkedUsers.length; i++)
              if (_checkedUsers[i].isChecked == true)
                InviteFriendCheckedItem(
                  data: _checkedUsers[i],
                  onChecked: (data) {
                    setState(() {
                      data.isChecked = false;
                    });
                  },
                )
              else
                const SizedBox()
          ],
        )
      ],
    );
  }
}
