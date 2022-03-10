import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_cult/app/data_source/local/hive_box_name.dart';
import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app/features/audio_player/audio_player.dart';
import 'app/injections.dart';
import 'app/services/audio_service.dart';
import 'di/bloc_locator.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  setupLocator();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  await openHiveBox(HiveBoxName.userProfileBox);
  await openHiveBox(HiveBoxName.cache);
  await openHiveBox('downloads');
  await openHiveBox('settings');
  await startService();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          await builder(),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final dir = await getApplicationDocumentsDirectory();
    final dirPath = dir.path;
    final dbFile = File('$dirPath/$boxName.hive');
    final lockFile = File('$dirPath/$boxName.lock');

    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    // ignore: only_throw_errors
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 500) {
    await box.clear();
  }
}

Future<void> startService() async {
  final audioHandler = await AudioService.init(
    builder: AudioPlayerHandlerImpl.new,
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.audiocult.channel.audio',
      androidNotificationChannelName: 'Audiocult',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'drawable/ic_stat_music_note',
      androidShowNotificationBadge: true,
      // androidStopForegroundOnPause: Hive.box('settings')
      // .get('stopServiceOnPause', defaultValue: true) as bool,
      notificationColor: Colors.grey[900],
    ),
  );
  locator.registerSingleton<AudioPlayerHandler>(audioHandler);
}
