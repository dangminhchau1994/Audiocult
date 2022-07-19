import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/features/atlas/subscribe_user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/bloc_state.dart';
import '../../data_source/models/requests/profile_request.dart';
import '../../data_source/models/responses/atlas_user.dart';
import '../../data_source/models/responses/profile_data.dart';
import '../../data_source/repositories/app_repository.dart';
import '../../utils/constants/app_constants.dart';

class ProfileBloc extends BaseBloc<ProfileRequest, ProfileData> {
  final AppRepository _appRepository;
  final _getListSubscriptionsSubject = PublishSubject<BlocState<List<ProfileData>>>();
  final _uploadAvatarSubject = PublishSubject<String>();
  final _subscribeSubject = PublishSubject<int>();
  Stream<BlocState<List<ProfileData>>> get getListSubscriptionsStream => _getListSubscriptionsSubject.stream;
  Stream<String> get uploadAvatarStream => _uploadAvatarSubject.stream;
  Stream<int> get subscribeStream => _subscribeSubject.stream;
  final SubscribeUserBloc _subscribeUserBloc;

  String? get currency => _appRepository.getCurrency();

  ProfileBloc(this._appRepository, this._subscribeUserBloc);

  @override
  Future<Either<ProfileData, Exception>> loadData(ProfileRequest? params) async {
    final result = await _appRepository.getUserProfile(params?.userId);
    return result;
  }

  void subscribeUser(AtlasUser user) async {
    showOverLayLoading();
    final result = await _appRepository.subscribeUser(user);
    hideOverlayLoading();
    result.fold(
      (subscribeResponse) {
        if (subscribeResponse.status == RequestStatus.success && subscribeResponse.error == null) {
          _subscribeSubject.add(
              user.isSubscribed == true ? SubscriptionStatus.unsubscribe.value : SubscriptionStatus.subscribe.value);
          if (user.userId?.isNotEmpty == true) {
            _subscribeUserBloc.subscriptionOnChange(user.userId!, runtimeType);
          }
        }
      },
      showError,
    );
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

  void uploadAvatar(XFile value) async {
    showOverLayLoading();
    final results = await _appRepository.uploadAvatar(value);
    hideOverlayLoading();
    results.fold(_uploadAvatarSubject.add, showError);
  }
}
