import 'package:audio_cult/app/features/auth/check_email/check_mail_screen.dart';
import 'package:audio_cult/app/features/auth/login/login_screen.dart';
import 'package:audio_cult/app/features/auth/place_location/place_location_screen.dart';
import 'package:audio_cult/app/features/auth/resent_password/resent_password_screen.dart';
import 'package:audio_cult/app/features/main/main_screen.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_screen.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_screen.dart';
import 'package:audio_cult/app/features/music/filter/music_filter_screen.dart';
import 'package:audio_cult/app/features/music/top_playlist/top_playlist_screen.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/music/featured_albums/featured_album_screen.dart';
import '../../features/music/search/search_args.dart';
import '../../features/music/search/search_screen.dart';
import '../../features/music/top_song/top_song_screen.dart';

class AppRoute {
  factory AppRoute() => _instance;

  AppRoute._private();

  ///#region ROUTE NAMES
  /// -----------------
  static const String routeRoot = '/';
  static const String routeMain = '/main';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeForgotPassword = '/forgot_password';
  static const String routeCheckEmail = '/check_email';
  static const String routeTopSongs = '/top_song';
  static const String routePlaceLocation = '/place_location';
  static const String routeFeaturedAlbum = 'featured_album';
  static const String routeTopPlaylist = 'top_playlist';
  static const String routeSearch = 'search';
  static const String routeMusicFilter = '/search';
  static const String routeDetaiSong = '/detail_song';

  ///#end region

  static final AppRoute _instance = AppRoute._private();

  static AppRoute get I => _instance;

  /// App route observer
  final RouteObserver<Route<dynamic>> routeObserver = RouteObserver<Route<dynamic>>();

  /// App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get app context
  BuildContext? get appContext => navigatorKey.currentContext;

  /// Generate route for app here
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeMain:
        return _pageRoute(settings, const MainScreen());
      case routeLogin:
        return _pageRoute(settings, const LoginScreen());
      case routeForgotPassword:
        return _pageRoute(settings, const ResentPasswordScreen());
      case routeCheckEmail:
        return _pageRoute(settings, const CheckMailScreen());
      case routeTopSongs:
        return _pageRoute(settings, const TopSongScreen());
      case routePlaceLocation:
        return _pageRoute(settings, const PlaceLocation());
      case routeMusicFilter:
        return _pageRoute(settings, const MusicFilterScreen());
      case routeDetaiSong:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          DetailSongScreen(
            songId: arguments['song_id'] as String,
          ),
        );
      case routeFeaturedAlbum:
        final SearchArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          FeaturedAlbumScreen(
            arguments: arguments!,
          ),
        );
      case routeTopPlaylist:
        final SearchArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          TopPlaylistScreen(
            arguments: arguments!,
          ),
        );
      case routeSearch:
        final SearchArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          SearchScreen(
            arguments: arguments!,
          ),
        );
      default:
        return null;
    }
  }

  static PageTransition<dynamic> _pageRoute(RouteSettings setting, Widget page, {PageTransitionType? transition}) =>
      PageTransition<dynamic>(
        child: page,
        type: transition ?? PageTransitionType.rightToLeftWithFade,
        settings: RouteSettings(name: setting.name, arguments: setting.arguments),
      );
}
