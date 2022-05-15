// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/privacy_settings/privacy_settings_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class PrivacySettingsBloc extends BaseBloc {
  final AppRepository _appRepo;
  List<PrivacySettingItem>? _privacyProfile;
  List<PrivacySettingItem>? _privacyItem;

  final _loadPrivacyProfileStreamController = StreamController<BlocState<List<PrivacySettingItem>>>.broadcast();
  Stream<BlocState<List<PrivacySettingItem>>> get loadPrivacyProfileStream =>
      _loadPrivacyProfileStreamController.stream;

  final _loadPrivacyItemStreamController = StreamController<BlocState<List<PrivacySettingItem>>>.broadcast();
  Stream<BlocState<List<PrivacySettingItem>>> get loadPrivacyItemStream => _loadPrivacyItemStreamController.stream;

  PrivacySettingsBloc(this._appRepo);

  void loadPrivacySettings() async {
    final result = await _appRepo.getPrivacySettings();
    result.fold((l) {
      _privacyItem = l.item;
      _privacyProfile = l.profile;
      _loadPrivacyProfileStreamController.sink.add(BlocState.success(_privacyProfile ?? []));
      _loadPrivacyItemStreamController.sink.add(BlocState.success(_privacyItem ?? []));
    }, (r) {
      _loadPrivacyProfileStreamController.sink.add(BlocState.error(r.toString()));
      _loadPrivacyItemStreamController.sink.add(BlocState.error(r.toString()));
    });
  }

  void repushPrivacyProfileStreamIfNeed(bool isTrue) {
    if (!isTrue) return;
    _loadPrivacyProfileStreamController.sink.add(BlocState.success(_privacyProfile ?? []));
  }

  void repushPrivacyItemStreamIfNeed(bool isTrue) {
    if (!isTrue) return;
    _loadPrivacyItemStreamController.sink.add(BlocState.success(_privacyItem ?? []));
  }
}
