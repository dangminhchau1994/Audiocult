import 'package:flutter/material.dart';

import '../constants/app_font_sizes.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#",
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension AppTextExtension on BuildContext {
//   button,
//   header,
//   text,
//   body,
//   body2,
//   bar,
//   description,
//   title,
//   subTitle

  TextTheme textTheme() => Theme.of(this).textTheme;

  TextStyle? headerStyle() => textTheme().headline6?.copyWith(color: Colors.white, fontWeight: FontWeight.w700);

  TextStyle? headerStyle1() => textTheme().headline5?.copyWith(color: Colors.white, fontWeight: FontWeight.w700);

  TextStyle? bodyTextStyle() => textTheme().bodyText2;

  TextStyle? buttonTextStyle() => bodyTextStyle()?.copyWith(fontSize: AppFontSize.size14, fontWeight: FontWeight.w600);

  TextStyle? bodyTextPrimaryStyle() => textTheme().bodyText2?.copyWith(
        fontWeight: FontWeight.w400,
      );

  TextStyle? bodyTextAccentStyle() => textTheme().bodyText2?.copyWith(
        fontWeight: FontWeight.w400,
      );

  TextStyle? body3TextStyle() => textTheme().bodyText2?.copyWith(
        fontWeight: FontWeight.w400,
      );

  TextStyle? body2TextStyle() => textTheme().bodyText2?.copyWith(
        fontWeight: FontWeight.w400,
      );

  TextStyle? body1TextStyle() => textTheme().bodyText2;

  TextStyle? title1TextStyle() => textTheme().bodyText2?.copyWith(
        fontWeight: FontWeight.w700,
      );

  TextStyle? subtitleTextStyle() => textTheme().bodyText1?.copyWith(
        fontWeight: FontWeight.w400,
      );
}
