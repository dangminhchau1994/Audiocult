import 'package:audio_cult/app/features/auth/login/login_screen.dart';
import 'package:audio_cult/app/features/main/main_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import '../features/splash/splash_bloc.dart';
import '../features/splash/splash_screen.dart';
import '../utils/configs/custom_scroll_behavior.dart';
import '../utils/route/app_route.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final SplashBloc _splashBloc = SplashBloc(locator.get(), locator.get());
  @override
  void initState() {
    super.initState();
    _splashBloc.checkScreen();
  }

  @override
  Widget build(BuildContext context) {
    final appRoute = context.watch<AppRoute>();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.secondaryButtonColor, // Color for Android
        statusBarBrightness: Brightness.dark, // Dark == white status bar -- for IOS.
      ),
    );
    return GlobalLoaderOverlay(
      overlayColor: Colors.black87,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          hintColor: Colors.white,
          fontFamily: AppAssets.fontFamily,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.white,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
          tabBarTheme: TabBarTheme(
            labelColor: AppColors.activeLabelItem,
            unselectedLabelColor: AppColors.unActiveLabelItem,
            indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.activeLabelItem, width: 2)),
          ),
          textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: StreamBuilder<StatePage>(
          stream: _splashBloc.checkLoginSubject.stream,
          initialData: StatePage.init,
          builder: (context, snapshot) {
            return handlePage(snapshot.data!);
          },
        ),
        initialRoute: AppRoute.routeRoot,
        onGenerateRoute: appRoute.generateRoute,
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(
            context,
            ScrollConfiguration(behavior: const CustomScrollBehavior(), child: widget!),
          ),
          backgroundColor: AppColors.mainColor,
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
      ),
    );
  }

  Widget handlePage(StatePage data) {
    switch (data) {
      case StatePage.init:
        return const SplashScreen();
      case StatePage.login:
        _splashBloc.dispose();
        return const LoginScreen();
      case StatePage.main:
        _splashBloc.dispose();
        return const MainScreen();
      // ignore: no_default_cases
      default:
        return Container();
    }
  }
}
