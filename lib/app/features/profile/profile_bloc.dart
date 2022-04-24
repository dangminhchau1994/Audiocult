import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/bloc_state.dart';
import '../../data_source/models/requests/profile_request.dart';
import '../../data_source/models/responses/profile_data.dart';
import '../../data_source/models/responses/subscriptions_response.dart';
import '../../data_source/repositories/app_repository.dart';

class ProfileBloc extends BaseBloc<ProfileRequest, ProfileData> {
  final AppRepository _appRepository;
  final _getListSubscriptionsSubject = PublishSubject<BlocState<List<Subscriptions>>>();
  Stream<BlocState<List<Subscriptions>>> get getListSubscriptionsStream => _getListSubscriptionsSubject.stream;

  ProfileBloc(this._appRepository);

  @override
  Future<Either<ProfileData, Exception>> loadData(ProfileRequest? params) async {
    final result = await _appRepository.getUserProfile(params?.userId);
    return result;
  }

  void getListSubscriptions(String? userId, int page, int limit) async {
    _getListSubscriptionsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getListSubscriptions(userId, page, limit);
    result.fold((l) {
      _getListSubscriptionsSubject.sink.add(BlocState.success(l));
    }, (r) {
      _getListSubscriptionsSubject.sink.add(BlocState.error(r.toString()));
    });
  }
}
