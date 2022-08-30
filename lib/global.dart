import 'package:audio_cult/app/features/music/library/library_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/utils/configs/app_config.dart';
import 'app/utils/flavor/flavor.dart';
import 'app/utils/route/app_route.dart';

class MyGlobal extends StatelessWidget {
  final Widget child;
  final FlavorConfig flavorConfig;
  const MyGlobal({Key? key, required this.child, required this.flavorConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppConfig(
      flavorConfig: flavorConfig,
      childC: MultiProvider(
        // ignore: prefer_const_literals_to_create_immutables
        providers: [
          //provider of app to global
          Provider<AppRoute>(create: (_) => AppRoute()),
        ],
        child: child,
      ),
    );
  }
}

class StripePaymentPublicKey {
  static const String keyTest =
      'pk_test_51Jjgj7BdGMMunEoGYLgrFo81nWCM0DhP8V3AkSqb9Nst8Dgcslm9RRQPbel3mkyYJVRo5OIasoo2WzUlDgpS4DD900O9gc13xz';
  static const String keyPro =
      'pk_live_51Iy6RsDeve528Qr3dd5eSImYbpctnD9rTMdi5eldypRzNwSjs6LZhR1nOa4MgVNLjkcj9Cmohu8l0mvHUVv700Jc00qV2pSm2B';
}
