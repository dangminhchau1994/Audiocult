import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

typedef UserSubscriptionDataType = Map<String?, bool?>;

class AtlasFilterResultBloc extends BaseBloc {
  final AppRepository appRepository;
  final UserSubscriptionDataType _subscriptionsInProcess = {};
  final _updatedSubscriptionData = <AtlasUser>[];
  final _allUsers = <AtlasUser>[];

  final _getAtlasUsers = StreamController<Tuple2<List<AtlasUser>, Exception?>>.broadcast();
  Stream<Tuple2<List<AtlasUser>, Exception?>> get getAtlasUsersStream => _getAtlasUsers.stream;

  final _updatedUserSubscription = StreamController<Tuple2<List<AtlasUser>, UserSubscriptionDataType>>.broadcast();
  Stream<Tuple2<List<AtlasUser>, UserSubscriptionDataType>> get updatedUserSubscriptionStream =>
      _updatedUserSubscription.stream;

  AtlasFilterResultBloc(this.appRepository);

  void getUsers(FilterUsersRequest request) async {
    if (request.page == 1) {
      showOverLayLoading();
      _allUsers.clear();
    }
    final result = await appRepository.getAtlasUsers(request);
    hideOverlayLoading();
    result.fold((users) {
      _getAtlasUsers.add(Tuple2(users, null));
    }, (error) {
      _getAtlasUsers.add(Tuple2([], error));
    });
  }

  void updateUsersList(List<AtlasUser> users) {
    _allUsers.addAll(users);
  }

  void subcribeUser(AtlasUser user) async {
    _subscriptionsInProcess[user.userId] = true;
    _updatedUserSubscription.add(Tuple2(_updatedSubscriptionData, _subscriptionsInProcess));
    final result = await appRepository.subcribeUser(user);
    result.fold(
      (subcribeResponse) {
        _subscriptionsInProcess[user.userId] = false;
        if (subcribeResponse.status == RequestStatus.success && subcribeResponse.error == null) {
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
    (filteredUser.isSubcribed ?? true) ? filteredUser.unsubcribe() : filteredUser.subscribe();
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
}
