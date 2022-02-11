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
