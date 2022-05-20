import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
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
    _initAwesomeNotification();
    _getFCMToken();
    _getNotificationData();
  }

  void _getNotificationData() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      final android = message.notification?.android;
      if (notification != null && android != null) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
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
    debugPrint('fcmToken: $fcmToken');
    await prefProvider.setFCMToken(fcmToken ?? '');
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
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Allow Notifications'),
              content: const Text('Our app would like to send you notifications'),
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
