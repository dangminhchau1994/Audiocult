import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../base/bloc_state.dart';

typedef UserSubscriptionDataType = Map<String?, bool?>;

class AtlasBloc extends BaseBloc {
  final AppRepository _appRepository;
  final UserSubscriptionDataType _subscriptionsInProcess = {};
  final _allUsers = <AtlasUser>[];
  final _updatedSubscriptionData = <AtlasUser>[];

  final _getAtlasUsers = PublishSubject<BlocState<Tuple2<List<AtlasUser>, Exception?>>>();
  Stream<BlocState<Tuple2<List<AtlasUser>, Exception?>>> get getAtlasUsersStream => _getAtlasUsers.stream;

  final _updatedUserSubscription = StreamController<Tuple2<List<AtlasUser>, UserSubscriptionDataType>>.broadcast();
  Stream<Tuple2<List<AtlasUser>, UserSubscriptionDataType>> get updatedUserSubscriptionStream =>
      _updatedUserSubscription.stream;

  AtlasBloc(this._appRepository);

  Future<void> getAtlasUsers(int pageNumber) async {
    if (pageNumber == 1) {
      _allUsers.clear();
    }
    final result = await _appRepository.getAtlasUsers(FilterUsersRequest(page: pageNumber));
    return result.fold(
      (users) {
        _allUsers.addAll(users);
        _getAtlasUsers.sink.add(BlocState.success(Tuple2(users, null)));
      },
      (error) {
        _getAtlasUsers.sink.add(BlocState.success(Tuple2([], error)));
      },
    );
  }

  Future<void> refreshAtlasUserData() async {
    _allUsers.clear();
    _updatedSubscriptionData.clear();
    _subscriptionsInProcess.clear();
    await getAtlasUsers(1);
  }

  void subscribeUser(AtlasUser user) async {
    _subscriptionsInProcess[user.userId] = true;
    _updatedUserSubscription.add(Tuple2(_updatedSubscriptionData, _subscriptionsInProcess));
    final result = await _appRepository.subscribeUser(user);
    result.fold(
      (subscribeResponse) {
        _subscriptionsInProcess[user.userId] = false;
        if (subscribeResponse.status == RequestStatus.success && subscribeResponse.error == null) {
          _updateSubscriptionDataOfUser(user);
        }
      },
      (error) {
        _subscriptionsInProcess[user.userId] = false;
        _cancelSubscriptionInProcess(user);
      },
    );
  }

  void _updateSubscriptionDataOfUser(AtlasUser user) {
    final filteredUser = _allUsers.firstWhereOrNull((element) => element.userId == user.userId);
    if (filteredUser == null) return;
    (filteredUser.isSubscribed ?? true) ? filteredUser.unsubscribe() : filteredUser.subscribe();
    _updatedSubscriptionData.removeWhere((element) => element.userId == user.userId);
    _allUsers.removeWhere((element) => element.userId == user.userId);
    _allUsers.add(filteredUser);
    _updatedSubscriptionData.add(filteredUser);
    _updatedUserSubscription.add(Tuple2(_updatedSubscriptionData, _subscriptionsInProcess));
  }

  void _cancelSubscriptionInProcess(AtlasUser user) {
    _subscriptionsInProcess[user.userId] = false;
    _updatedUserSubscription.add(Tuple2(_updatedSubscriptionData, _subscriptionsInProcess));
  }

  @override
  void dispose() {
    _getAtlasUsers.close();
    _updatedUserSubscription.close();
    super.dispose();
  }
}
