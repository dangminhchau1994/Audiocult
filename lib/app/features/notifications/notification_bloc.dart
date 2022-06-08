import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/notification_request.dart';
import 'package:audio_cult/app/data_source/models/responses/notifications/notification_response.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/subjects.dart';

import '../../data_source/repositories/app_repository.dart';

class NotificationBloc extends BaseBloc<NotificationRequest, List<NotificationResponse>> {
  final AppRepository _appRepository;

  NotificationBloc(this._appRepository);

  final _markAllReadSubject = PublishSubject<BlocState<List<NotificationResponse>>>();
  Stream<BlocState<List<NotificationResponse>>> get _markAllReadStream => _markAllReadSubject.stream;

  @override
  Future<Either<List<NotificationResponse>, Exception>> loadData(NotificationRequest? params) async {
    final result = await _appRepository.getNotifications(params ?? NotificationRequest());
    return result;
  }

  void markAllRead() async {
    final result = await _appRepository.markAllRead();

    result.fold((success) {
      _markAllReadSubject.sink.add(BlocState.success(success));
    }, (error) {
      _markAllReadSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
