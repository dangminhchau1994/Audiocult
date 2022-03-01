// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';

enum Flavor { dev, production, staging }

class FlavorValues {
  FlavorValues({
    @required this.mainUrl,
    @required this.placeUrl,
  });

  final String? mainUrl;
  final String? placeUrl;
}

class FlavorConfig {
  FlavorConfig._internal(this.flavor, this.values);
  // ignore: sort_unnamed_constructors_first
  factory FlavorConfig({@required Flavor? flavor, @required FlavorValues? values}) {
    return _instance ??= FlavorConfig._internal(flavor, values);
  }
  final Flavor? flavor;
  final FlavorValues? values;
  static FlavorConfig? _instance;

  static FlavorConfig? get instance {
    return _instance;
  }

  static bool isProduction() => _instance?.flavor == Flavor.production;

  static bool isDevelopment() => _instance?.flavor == Flavor.dev;

  static bool isStaging() => _instance?.flavor == Flavor.staging;
}
