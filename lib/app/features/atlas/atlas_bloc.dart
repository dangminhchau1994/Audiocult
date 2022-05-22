import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/features/atlas/subscribe_user_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../base/bloc_state.dart';

typedef UserSubscriptionDataType = Map<String?, bool?>;

class AtlasBloc extends BaseBloc {
  final AppRepository _appRepository;
  final SubscribeUserBloc _subscribeUserBloc;
  final UserSubscriptionDataType _subscriptionsInProcess = {};
  List<AtlasUser>? _allUsers;
  final _updatedSubscriptionData = <AtlasUser>[];
  final maximumNumberOfItems = 24;
  String? _keyword;
  CancelToken? _cancel;
  List<AtlasUser>? get allUsers => _allUsers;

  final _getAtlasUsers = PublishSubject<BlocState<Tuple2<List<AtlasUser>, Exception?>>>();
  Stream<BlocState<Tuple2<List<AtlasUser>, Exception?>>> get getAtlasUsersStream => _getAtlasUsers.stream;

  final _updatedUserSubscription = StreamController<Tuple2<List<AtlasUser>, UserSubscriptionDataType>>.broadcast();
  Stream<Tuple2<List<AtlasUser>, UserSubscriptionDataType>> get updatedUserSubscriptionStream =>
      _updatedUserSubscription.stream;

  AtlasBloc(this._appRepository, this._subscribeUserBloc) {
    _subscribeUserBloc.subsriptionOnChangeStream.listen((data) {
      if (data.value2 == runtimeType) return;
      _updateSubscriptionDataOfUser(AtlasUser()..userId = data.value1);
    });
  }

  Future<void> getAtlasUsers(int pageNumber) async {
    _cancel?.cancel();
    _cancel = CancelToken();
    if (pageNumber == 1) {
      await refreshAtlasUserData();
    }
    final result = await _appRepository.getAtlasUsers(
      FilterUsersRequest(keyword: _keyword, page: pageNumber),
      cancel: _cancel,
    );
    return result.fold(
      (users) {
        (_allUsers ??= []).addAll(users);
        _getAtlasUsers.sink.add(BlocState.success(Tuple2(users, null)));
      },
      (error) {
        _getAtlasUsers.sink.add(BlocState.success(Tuple2([], error)));
      },
    );
  }

  Future<void> refreshAtlasUserData() async {
    _allUsers?.clear();
    _updatedSubscriptionData.clear();
    _subscriptionsInProcess.clear();
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
    final filteredUser = _allUsers?.firstWhereOrNull((element) => element.userId == user.userId);
    if (filteredUser == null) return;
    (filteredUser.isSubscribed ?? true) ? filteredUser.unsubscribe() : filteredUser.subscribe();
    _updatedSubscriptionData.removeWhere((element) => element.userId == user.userId);
    _updatedSubscriptionData.add(filteredUser);
    _allUsers?.removeWhere((element) => element.userId == user.userId);
    _allUsers?.add(filteredUser);
    _updatedUserSubscription.add(Tuple2(_updatedSubscriptionData, _subscriptionsInProcess));
  }

  void _cancelSubscriptionInProcess(AtlasUser user) {
    _subscriptionsInProcess[user.userId] = false;
    _updatedUserSubscription.add(Tuple2(_updatedSubscriptionData, _subscriptionsInProcess));
  }

  void keywordOnChanged(String keyword) {
    if ((_keyword ?? '').isEmpty && keyword.isEmpty) {
      return;
    }
    refreshAtlasUserData();
    _keyword = keyword;
  }

  @override
  void dispose() {
    _getAtlasUsers.close();
    _updatedUserSubscription.close();
    _subscribeUserBloc.dispose();
    super.dispose();
  }
}
