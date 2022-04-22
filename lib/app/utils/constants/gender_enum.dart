import 'package:flutter/cupertino.dart';

enum Gender { none, male, female, alien, panda, custom }

extension GenderExtension on Gender {
  String title(BuildContext context) {
    switch (this) {
      case Gender.none:
        return 'Please select';
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.alien:
        return 'alien';
      case Gender.panda:
        return 'panda';
      case Gender.custom:
        return 'Custom';
    }
  }

  int? get index {
    switch (this) {
      case Gender.none:
        return null;
      case Gender.male:
        return 1;
      case Gender.female:
        return 2;
      case Gender.alien:
        return 3;
      case Gender.panda:
        return 4;
      case Gender.custom:
        return -1;
    }
  }
}
