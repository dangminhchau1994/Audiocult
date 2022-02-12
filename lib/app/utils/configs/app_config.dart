import 'package:flutter/material.dart';

import '../flavor/flavor.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({Key? key, required this.childC, required this.flavorConfig}) : super(key: key, child: childC);

  final Widget childC;
  final FlavorConfig flavorConfig;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
