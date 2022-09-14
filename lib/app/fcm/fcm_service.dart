import 'dart:math';
import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/fcm/fcm_bloc.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/route/app_route.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Message from background : ');
}

class FCMService {
  final BuildContext? context;
  final PrefProvider prefProvider;
  Map<String, dynamic> data = {};

  FCMService(
    this.context,
    this.prefProvider,
  );

  void initialize() async {
    _tapNotificationTerminated();
    _setNotificationBackGround();
    _initAwesomeNotification();
    _setUpForeGroundIOS();
    _getFCMToken();
    _getNotificationData();
    _tapNotificationForeGround();
    _tapNotificationBackGround();
  }

  void _navigateScreen(Map<String, dynamic> data) {
    final type = data['type_id'] as String;
    final itemId = data['item_id'] as dynamic;
    final userId = data['user_id'] as dynamic;

    switch (type) {
      case GlobalConstants.visitorNew:
        Navigator.pushNamed(
          context!,
          AppRoute.routeProfile,
          arguments: ProfileScreen.createArguments(id: userId as String),
        );
        break;
      case GlobalConstants.commentMusic:
        Navigator.pushNamed(
          context!,
          AppRoute.routeDetailSong,
          arguments: {
            'song_id': itemId,
            'from_notification': true,
          },
        );
        break;
      case GlobalConstants.commentAlbum:
        Navigator.pushNamed(
          context!,
          AppRoute.routeDetailAlbum,
          arguments: {
            'album_id': itemId,
            'from_notification': true,
          },
        );
        break;
      case GlobalConstants.commentEvent:
        Navigator.pushNamed(
          context!,
          AppRoute.routeEventDetail,
          arguments: {
            'event_id': int.parse(itemId as String),
            'from_notification': true,
          },
        );
        break;
      default:
    }
  }

  void _setNotificationBackGround() {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  void _tapNotificationTerminated() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      _navigateScreen(message?.data ?? {});
    });
  }

  void _tapNotificationForeGround() {
    AwesomeNotifications().actionStream.listen((ReceivedNotification receivedNotification) {
      _navigateScreen(data);
    });
  }

  void _tapNotificationBackGround() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('dataBackground: ${message.data}');
      _navigateScreen(message.data);
    });
  }

  void _setUpForeGroundIOS() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _setBadge() async {
    final _prefProvider = locator<PrefProvider>();
    await _prefProvider.setShowBadge(1);
    getIt<FCMBloc>().showBadge(_prefProvider.showBadge ?? 0);
    if (_prefProvider.countBadge == null) {
      await _prefProvider.setCountBadge(_prefProvider.countBadge ?? 0 + 1);
    } else {
      await _prefProvider.setCountBadge(_prefProvider.countBadge! + 1);
    }
    getIt<FCMBloc>().countBadge(locator<PrefProvider>().countBadge ?? 0);
  }

  void _getNotificationData() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      final android = message.notification?.android;
      data = message.data;

      _setBadge();
      if (notification != null && android != null) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: Random().nextInt(1000),
            channelKey: 'basic_channel',
            title: notification.title,
            body: notification.body,
            bigPicture: AppAssets.notificationIcon,
          ),
        );
      }
    });
  }

  void _getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await prefProvider.setFCMToken(fcmToken ?? '');
    debugPrint('fcmToken $fcmToken');
  }

  void _initAwesomeNotification() {
    AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher_png',
      [
        NotificationChannel(
          channelDescription: '',
          channelName: 'Basic Notifications',
          channelKey: 'basic_channel',
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );
  }

  void askPermission() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context!,
            barrierDismissible: false,
            builder: (context) => CupertinoAlertDialog(
              title: Text(context.localize.t_allow_notis),
              content: Text(context.localize.t_noti_request_message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Don't Allow",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications().requestPermissionToSendNotifications().then(
                        (_) => Navigator.pop(context),
                      ),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
