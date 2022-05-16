import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum Gender {
  @JsonValue('0')
  none,
  @JsonValue('1')
  male,
  @JsonValue('2')
  female,
  @JsonValue('3')
  alien,
  @JsonValue('4')
  panda,
  @JsonValue('127')
  custom
}

extension GenderExtension on Gender {
  String title(BuildContext context) {
    switch (this) {
      case Gender.none:
        return '...';
      case Gender.male:
        return context.l10n.t_male;
      case Gender.female:
        return context.l10n.t_female;
      case Gender.alien:
        return context.l10n.t_alian;
      case Gender.panda:
        return context.l10n.t_panda;
      case Gender.custom:
        return context.l10n.t_custom;
    }
  }

  String? get paramValue {
    switch (this) {
      case Gender.none:
        return null;
      case Gender.male:
        return '1';
      case Gender.female:
        return '2';
      case Gender.alien:
        return '3';
      case Gender.panda:
        return '4';
      case Gender.custom:
        return 'custom';
    }
  }

  int? get indexs {
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
        return 127;
    }
  }

  static Gender initFromText(String? text) {
    switch ((text ?? '').toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'alien':
        return Gender.alien;
      case 'panda':
        return Gender.panda;
      default:
        return Gender.custom;
    }
  }
}
