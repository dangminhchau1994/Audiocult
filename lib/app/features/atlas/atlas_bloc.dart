import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../base/bloc_state.dart';

typedef UserSubscriptionDataType = Map<String?, bool?>;

class AtlasBloc extends BaseBloc {
  final AppRepository _appRepository;
  final UserSubscriptionDataType _subscriptionsInProcess = {};
  final _allUsers = <AtlasUser>[];

  final _getAtlasUsers = PublishSubject<BlocState<Tuple3<List<AtlasUser>, UserSubscriptionDataType, Exception?>>>();
  Stream<BlocState<Tuple3<List<AtlasUser>, UserSubscriptionDataType, Exception?>>> get getAtlasUsersStream =>
      _getAtlasUsers.stream;

  AtlasBloc(this._appRepository);

  Future<void> getAtlasUsers(int pageNumber) async {
    if (pageNumber == 1) {
      _allUsers.clear();
    }
    final result = await _appRepository.getAtlasUsers(pageNumber: pageNumber);
    return result.fold(
      (users) {
        _allUsers.addAll(users);
        _getAtlasUsers.sink.add(BlocState.success(Tuple3(users, _subscriptionsInProcess, null)));
      },
      (error) {
        _getAtlasUsers.sink.add(BlocState.success(Tuple3(_allUsers, _subscriptionsInProcess, error)));
      },
    );
  }

  Future<void> refreshAtlasUserData() async {
    _allUsers.clear();
    await getAtlasUsers(1);
  }

  void subcribeUser(AtlasUser user) async {
    _subscriptionsInProcess[user.userId] = true;
    _getAtlasUsers.sink.add(BlocState.success(Tuple3(_allUsers, _subscriptionsInProcess, null)));
    final result = await _appRepository.subcribeUser(user);
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
        showError(error);
      },
    );
  }

  void _updateSubscriptionDataOfUser(AtlasUser user) {
    final filteredUser = _allUsers.firstWhere((element) => element.userId == user.userId);
    (filteredUser.isSubcribed ?? true) ? filteredUser.unsubcribe() : filteredUser.subscribe();
    _getAtlasUsers.sink.add(BlocState.success(Tuple3(_allUsers, _subscriptionsInProcess, null)));
  }

  void _cancelSubscriptionInProcess(AtlasUser user) {
    _subscriptionsInProcess[user.userId] = false;
    _getAtlasUsers.sink.add(BlocState.success(Tuple3(_allUsers, _subscriptionsInProcess, null)));
  }

  @override
  void dispose() {
    _getAtlasUsers.close();
    super.dispose();
  }
}
