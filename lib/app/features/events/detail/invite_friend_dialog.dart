import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/get_invitation_request.dart';
import 'package:audio_cult/app/data_source/models/responses/event_invitation/event_invitation_response.dart';
import 'package:audio_cult/app/features/events/detail/invite_friend_bloc.dart';
import 'package:audio_cult/app/features/events/detail/invite_friend_item.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../w_components/textfields/common_input.dart';

class InviteFriendDialog extends StatefulWidget {
  const InviteFriendDialog({
    Key? key,
    this.eventId,
  }) : super(key: key);

  final int? eventId;

  @override
  State<InviteFriendDialog> createState() => _InviteFriendDialogState();
}

class _InviteFriendDialogState extends State<InviteFriendDialog> {
  final _bloc = InviteFriendBloc(locator.get());
  var _users = <EventInvitationResponse>[];

  @override
  void initState() {
    super.initState();
    _callData('');
  }

  void _callData(String keyword) {
    _bloc.getInvitation(GetInvitationRequest(
      itemId: widget.eventId,
      searchType: 'event',
      keyword: keyword,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                //_buildListUser(),
                const SizedBox(height: 12),
                _buildUnselectedAll(_users.length.toString()),
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
    );
  }

  Widget _buildSubmitButton() {
    return CommonButton(
      color: AppColors.primaryButtonColor,
      text: context.l10n.t_submit_button,
    );
  }

  Widget _buildSearch() {
    return CommonInput(
      hintText: context.l10n.t_search_email,
      onChanged: (value) {},
    );
  }

  Widget _buildInviteFriend() {
    return Text(
      context.l10n.t_invite_friend,
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
          context.l10n.t_add_personal_message,
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 8),
        CommonInput(
          maxLine: 3,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildInputMail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.t_invite_friend_mail,
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 8),
        CommonInput(
          maxLine: 3,
          hintText: context.l10n.t_seperate_email,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildUnselectedAll(String length) {
    return Visibility(
      visible: int.parse(length) > 0,
      child: Text(
        '${context.l10n.t_deselected_all} $length',
        style: context.bodyTextPrimaryStyle()!.copyWith(
              color: AppColors.activeLabelItem,
              fontSize: 16,
            ),
      ),
    );
  }

  Widget _buildListUser() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          StreamBuilder<BlocState<List<EventInvitationResponse>>>(
            stream: _bloc.getInviteStream,
            initialData: const BlocState.loading(),
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (success) {
                  _users = success as List<EventInvitationResponse>;

                  return Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _users
                        .map(
                          (e) => InviteFriendItem(
                            data: e,
                            onChecked: (data, isChecked) {
                              setState(() {
                                data.isChecked = isChecked;
                              });
                            },
                          ),
                        )
                        .toList(),
                  );
                },
                loading: () {
                  return const Center(
                    child: LoadingWidget(),
                  );
                },
                error: (error) {
                  return ErrorSectionWidget(
                    errorMessage: error,
                    onRetryTap: () {
                      _callData('');
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < _users.length; i++)
            _users[i].isChecked == true
                ? Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _users
                        .map(
                          (e) => Stack(
                            children: [
                              CachedNetworkImage(
                                width: 50,
                                height: 50,
                                imageUrl: e.userImage ?? '',
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryButtonColor,
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.inputFillColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _users[i].isChecked = false;
                                      });
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  )
                : const SizedBox()
        ],
      ),
    );
  }
}
