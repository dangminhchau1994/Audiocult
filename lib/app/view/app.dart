import 'package:audio_cult/app/features/auth/login/login_screen.dart';
import 'package:audio_cult/app/features/main/main_screen.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import '../utils/configs/custom_scroll_behavior.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, // Color for Android
        statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
        ,
      ),
    );
    return MaterialApp(
      theme: ThemeData(
        fontFamily: AppAssets.fontFarmily,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
        textTheme: const TextTheme().copyWith(
          bodyText1: const TextStyle(
            color: Colors.white,
          ),
          bodyText2: const TextStyle(
            color: Colors.white,
          ),
        ),
        tabBarTheme: TabBarTheme(
            labelColor: AppColors.activeLabelItem,
            unselectedLabelColor: AppColors.unActiveLabelItem,
            indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.activeLabelItem, width: 2.0))),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainScreen(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(
          context,
          ScrollConfiguration(behavior: const CustomScrollBehavior(), child: widget!),
        ),
        backgroundColor: Colors.white,
        maxWidth: MediaQuery.of(context).size.width,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      ),
    );
  }
}
