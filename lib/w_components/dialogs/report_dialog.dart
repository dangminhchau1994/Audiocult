import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/requests/report_request.dart';
import 'package:audio_cult/app/data_source/models/responses/reasons/reason_response.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';

import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dialogs/report_dialog_bloc.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app/base/bloc_state.dart';
import '../error_empty/error_section.dart';

enum ReportType {
  comment,
  video,
  playlist,
  song,
  album,
  photo,
  feed,
}

class ReportDialog extends StatefulWidget {
  const ReportDialog({
    Key? key,
    this.itemId,
    this.type,
  }) : super(key: key);

  final int? itemId;
  final ReportType? type;

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  var _reasons;
  final _bloc = ReportDialogBloc(locator.get());
  final _errorFeedback = '';
  final _request = ReportRequest();
  SelectMenuModel? _reasonSelection = SelectMenuModel(id: -1);

  String _getType(ReportType type) {
    switch (type) {
      case ReportType.comment:
        return GlobalConstants.reportComment;
      case ReportType.video:
        return GlobalConstants.reportVideo;
      case ReportType.playlist:
        return GlobalConstants.reportPlaylist;
      case ReportType.song:
        return GlobalConstants.reportSong;
      case ReportType.album:
        return GlobalConstants.reportAlbum;
      case ReportType.photo:
        return GlobalConstants.reportPhoto;
      case ReportType.feed:
        return GlobalConstants.reportFeed;
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc.getReasons();
    _bloc.reportStream.listen((event) {
      ToastUtility.showSuccess(context: context, message: context.localize.t_report_success);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _bloc,
      child: Material(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    _buildDiver(),
                    _buildTerms(),
                    _buildConfidential(),
                    _buildReasons(),
                    _buildFeedBackInput(),
                    _buildSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiver() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Divider(height: 0.5, color: Colors.grey.withOpacity(0.5)),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CommonButton(
        text: context.localize.t_submit,
        color: _reasonSelection?.id != -1 ? AppColors.primaryButtonColor : Colors.grey,
        onTap: _reasonSelection?.id != -1
            ? () {
                _request.itemId = widget.itemId;
                _request.type = _getType(widget.type!);
                if (_reasonSelection?.id != -1) {
                  _bloc.report(_request);
                }
                setState(() {});
              }
            : null,
      ),
    );
  }

  Widget _buildFeedBackInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localize.t_comment_optional,
            style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 6),
          CommonInput(
            maxLine: 3,
            errorText: _errorFeedback.isEmpty ? null : _errorFeedback,
            onChanged: (value) {
              _request.feedBack = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReasons() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localize.t_reason,
            style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          StreamBuilder<BlocState<List<ReasonResponse>>>(
            initialData: const BlocState.loading(),
            stream: _bloc.getReasonStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (success) {
                  final data = success as List<ReasonResponse>;

                  _reasons ??=
                      data.map((e) => SelectMenuModel(id: int.parse(e.reasonId ?? ''), title: e.message)).toList();
                  if (_reasons is List) {
                    (_reasons as List<SelectMenuModel>).map((e) {
                      if (e.id == _reasonSelection?.id) {
                        _reasonSelection = e;
                        e.isSelected = true;
                      }
                      return e;
                    }).toList();
                  }

                  return CommonDropdown(
                    selection: _reasonSelection,
                    hint: context.localize.t_choose_one,
                    data: _reasons as List<SelectMenuModel>,
                    onChanged: (value) {
                      setState(() {
                        _reasonSelection = value;
                        _request.reasonId = value?.id;
                      });
                    },
                  );
                },
                loading: () {
                  return const SizedBox();
                },
                error: (error) {
                  return ErrorSectionWidget(
                    errorMessage: error,
                    onRetryTap: _bloc.getReasons,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfidential() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        context.localize.t_stricly_confidential,
        style: context.body2TextStyle()?.copyWith(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        context.localize.t_report,
        style: context.body2TextStyle()?.copyWith(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildTerms() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: context.localize.t_report_violation,
              style: context.body2TextStyle()?.copyWith(color: Colors.white, fontSize: 16),
            ),
            TextSpan(
              text: context.localize.t_tearm_of_use,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, AppRoute.routeTerms);
                },
              style: context.body2TextStyle()?.copyWith(color: AppColors.activeLabelItem, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
