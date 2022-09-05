import 'package:after_layout/after_layout.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/fcm/fcm_service.dart';
import 'package:audio_cult/app/features/auth/login/login_screen.dart';
import 'package:audio_cult/app/features/main/main_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/flavor/flavor.dart';
import 'package:audio_cult/l10n/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:uni_links/uni_links.dart';

import '../features/splash/splash_bloc.dart';
import '../features/splash/splash_screen.dart';
import '../utils/configs/custom_scroll_behavior.dart';
import '../utils/route/app_route.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with AfterLayoutMixin<App> {
  final SplashBloc _splashBloc = SplashBloc(
    locator.get(),
    locator.get(),
    locator.get(),
  );
  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = FlavorConfig.instance!.values!.stripePubkey!;

    _splashBloc.checkScreen();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // _handleInitialUri();
    // _handleIncomingLinks(context);
  }

  Future<void> _handleInitialUri() async {
    try {
      await getInitialLink();
    } on PlatformException {
      debugPrint('error');
    }
  }

  void _handleIncomingLinks(BuildContext ctx) {
    uriLinkStream.listen((uri) {
      if (!mounted) return;
      final shortCode = uri;
      if (shortCode != null) {
        debugPrint(shortCode.toString());
        if (shortCode.path == '/user/password/verify/') {
          //hardcode unilink change password
          final hashId = shortCode.queryParameters['id'];
          if (!locator.get<PrefProvider>().isAuthenticated) {
            debugPrint(hashId);
            try {
              Navigator.pushNamed(navigatorKey.currentState!.context, AppRoute.routeResetPassword, arguments: hashId);
            } catch (e) {
              print(e);
            }
          }
        }
      }
    });
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
        navigatorKey: navigatorKey,
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
          textTheme: Theme.of(context).textTheme.copyWith(bodyText2: const TextStyle(fontSize: 16)).apply(
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
            FCMService(context, locator.get()).initialize();
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
