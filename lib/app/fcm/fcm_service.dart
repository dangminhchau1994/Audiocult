import 'dart:io';
import 'dart:math';

import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/fcm/fcm_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FCMService {
  final BuildContext? context;
  final PrefProvider prefProvider;

  FCMService(
    this.context,
    this.prefProvider,
  );

  void initialize() async {
    _getInitialMessage();
    _initAwesomeNotification();
    _setUpForeGroundIOS();
    _getFCMToken();
    _getNotificationData();
    _tapNotification();
  }

  void _getInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint('chauBE: ${message.data}');
      }
    });
  }

  void _tapNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('chauFE: ${message.data}');
    });
  }

  void _setUpForeGroundIOS() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _getNotificationData() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      final android = message.notification?.android;
      final _prefProvider = locator<PrefProvider>();

      await _prefProvider.setShowBadge(1);
      getIt<FCMBloc>().showBadge(_prefProvider.showBadge ?? 0);
      if (_prefProvider.countBadge == null) {
        await _prefProvider.setCountBadge(_prefProvider.countBadge ?? 0 + 1);
      } else {
        await _prefProvider.setCountBadge(_prefProvider.countBadge! + 1);
      }
      getIt<FCMBloc>().countBadge(locator<PrefProvider>().countBadge ?? 0);

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
              title: const Text('Allow Notifications'),
              content: const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    exit(0);
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
