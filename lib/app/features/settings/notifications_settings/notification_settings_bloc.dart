import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/notification_option.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class NotificationSettingsBloc extends BaseBloc {
  final AppRepository _appRepo;
  List<NotificationOption>? _notifications;

  final _loadAllNotificationStreamController = StreamController<BlocState<List<NotificationOption>>>.broadcast();
  Stream<BlocState<List<NotificationOption>>> get loadAllNotificationStream =>
      _loadAllNotificationStreamController.stream;

  final _enableUpdateButtonStreamController = StreamController<bool>.broadcast();
  Stream<bool> get enableUpdateButtonStream => _enableUpdateButtonStreamController.stream;

  final _updateNotificationData = StreamController<BlocState<String?>>.broadcast();
  Stream<BlocState<String?>> get updateNotificationStream => _updateNotificationData.stream;

  NotificationSettingsBloc(this._appRepo);

  void loadAllNotificationOptions() async {
    showOverLayLoading();
    final result = await _appRepo.getAllNotifications();
    result.fold(
      (notifications) {
        _notifications = notifications;
        _loadAllNotificationStreamController.sink.add(BlocState.success(notifications));
        hideOverlayLoading();
      },
      (exception) {
        hideOverlayLoading();
      },
    );
  }

  void notificationOptionsOnChanged(NotificationOption notification) {
    _enableUpdateButtonStreamController.sink.add(true);
    final updatedNotification = _notifications?.firstWhere((element) => element.key == notification.key);
    if (updatedNotification != null) {
      updatedNotification.isChecked = !(updatedNotification.isChecked ?? true);
    }
    _loadAllNotificationStreamController.sink.add(BlocState.success(_notifications ?? []));
  }

  void updateNotification() async {
    showOverLayLoading();
    final result = await _appRepo.updateNotificationData(_notifications!);
    result.fold((l) {
      _updateNotificationData.sink.add(const BlocState.success(null));
      hideOverlayLoading();
    }, (r) {
      _updateNotificationData.sink.add(BlocState.error(r.toString()));
      hideOverlayLoading();
    });
  }
}
