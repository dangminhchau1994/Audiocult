import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/notification_option.dart';
import 'package:audio_cult/app/features/settings/notifications_settings/notification_settings_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'notification_option_widget.dart';

class NotificationSettingsWidget extends StatefulWidget {
  const NotificationSettingsWidget({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsWidget> createState() => _NotificationSettingsWidgetState();
}

class _NotificationSettingsWidgetState extends State<NotificationSettingsWidget> with AutomaticKeepAliveClientMixin {
  late NotificationSettingsBloc _bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<NotificationSettingsBloc>();
    _bloc.loadAllNotificationOptions();
    _bloc.updateNotificationStream.listen((event) {
      event.whenOrNull(
        success: (_) {
          ToastUtility.showSuccess(context: context, message: context.l10n.t_success);
        },
        error: (exception) {
          ToastUtility.showError(context: context, message: exception);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: BlocHandle(
        bloc: _bloc,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.t_notification_settings,
                style: context.title1TextStyle(),
              ),
              const SizedBox(height: 24),
              _notificationListView(),
              const SizedBox(height: 40),
              _updateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationListView() {
    return StreamBuilder<BlocState<List<NotificationOption>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.loadAllNotificationStream,
      builder: (_, snapshot) {
        final state = snapshot.data;
        return state?.when(
              success: (notifications) {
                final notis = notifications as List<NotificationOption>;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notis.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: NotificationOptionWidget(
                        '${notis[index].phrase}',
                        state: notis[index].isChecked,
                        stateOnchanged: (state) {
                          _bloc.notificationOptionsOnChanged(notis[index]);
                        },
                      ),
                    );
                  },
                );
              },
              loading: LoadingWidget.new,
              error: (error) {
                return ErrorWidget(error);
              },
            ) ??
            Container();
      },
    );
  }

  Widget _updateButton() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _bloc.enableUpdateButtonStream,
      builder: (_, snapshot) {
        return CommonButton(
          color: AppColors.primaryButtonColor,
          text: context.l10n.t_update,
          onTap: snapshot.data == false ? null : _bloc.updateNotification,
        );
      },
    );
  }
}
