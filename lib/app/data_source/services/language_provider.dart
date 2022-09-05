import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/responses/localized_text.dart';
import 'package:audio_cult/app/data_source/services/app_service_provider.dart';
import 'package:audio_cult/app/data_source/services/assets_local_provider.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:path_provider/path_provider.dart';

class LanguageProvider {
  late AssetsLocalServiceProvider _assetProvider;
  late AppServiceProvider _appServiceProvider;
  late LocalizedText? _localizedText;
  late PrefProvider? _prefProvider;

  final _localizedTextStreamController = StreamController<LocalizedText>.broadcast();

  LocalizedText get localizedText => _localizedText!;

  Stream<LocalizedText> get localizedTextStream => _localizedTextStreamController.stream;

  LanguageProvider({
    required AssetsLocalServiceProvider assetProvider,
    required AppServiceProvider appServiceProvider,
    required PrefProvider prefProvider,
  }) {
    _appServiceProvider = appServiceProvider;
    _assetProvider = assetProvider;
    _localizedText = LocalizedText.fromJson({});
    _prefProvider = prefProvider;
    initLocalizedText('');
  }

  Future<void> initLocalizedText(String languageId) async {
    if (_prefProvider?.isAuthenticated != true) {
      _localizedText = await _assetProvider.getLocalizedText();
      return;
    }
    if (languageId.isNotEmpty == true) {
      try {
        final localizedTextData = await _appServiceProvider.getLocalizedTextData(languageId);
        if (localizedTextData != null) {
          await writeToLocalFile(json.encode(localizedTextData));
          _localizedText = LocalizedText.fromJson(localizedTextData);
        } else {
          _localizedText = await readFromLocalFile();
        }
      } catch (_) {
        _localizedText = await _assetProvider.getLocalizedText();
      }
    } else {
      _localizedText = await _assetProvider.getLocalizedText();
    }
    _localizedTextStreamController.sink.add(_localizedText!);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${AppConstants.backupLocalizedFile}');
  }

  Future<File?> writeToLocalFile(String string) async {
    try {
      final file = await _localFile;
      return file.writeAsString(string);
    } catch (e) {
      return null;
    }
  }

  Future<LocalizedText> readFromLocalFile() async {
    try {
      final file = await _localFile;
      final string = await file.readAsString();
      final mappingData = json.decode(string) as Map<String, dynamic>;
      final localizedText = LocalizedText.fromJson(mappingData);
      return localizedText;
    } catch (e) {
      return LocalizedText.fromJson({});
    }
  }
}
