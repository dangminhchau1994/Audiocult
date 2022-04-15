import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/features/atlas_filter/atlas_filter_provider.dart';
import 'package:audio_cult/app/features/atlas_filter/atlas_filter_screen.dart';
import 'package:audio_cult/app/features/atlas_filter_result/atlas_filter_result_screen.dart';
import 'package:audio_cult/app/features/auth/check_email/check_mail_screen.dart';
import 'package:audio_cult/app/features/auth/login/login_screen.dart';
import 'package:audio_cult/app/features/auth/place_location/place_location_screen.dart';
import 'package:audio_cult/app/features/auth/resent_password/resent_password_screen.dart';
import 'package:audio_cult/app/features/events/calendar/calendar_screen.dart';
import 'package:audio_cult/app/features/events/create_event/create_event_screen.dart';
import 'package:audio_cult/app/features/events/detail/event_detail_screen.dart';
import 'package:audio_cult/app/features/events/filter/filter_event_screen.dart';
import 'package:audio_cult/app/features/events/result/result_screen.dart';
import 'package:audio_cult/app/features/main/main_screen.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_screen.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_screen.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_screen.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_screen.dart';
import 'package:audio_cult/app/features/music/featured_mixtape/featured_mixtapes_screen.dart';
import 'package:audio_cult/app/features/music/filter/music_filter_screen.dart';
import 'package:audio_cult/app/features/music/library/create_playlist_screen.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_screen.dart';
import 'package:audio_cult/app/features/music/top_playlist/top_playlist_screen.dart';
import 'package:audio_cult/app/features/my_diary_in_month/my_diary_in_month_screen.dart';
import 'package:audio_cult/app/features/player_widgets/player_screen.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_edit_screen.dart';
import 'package:audio_cult/w_components/comment/comment_list_screen.dart';
import 'package:audio_cult/w_components/comment/reply_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../features/events/map/map_screen.dart';
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
  static const String routeDetailSong = '/detail_song';
  static const String routeDetailAlbum = '/detail_album';
  static const String routeDetailPlayList = '/detail_playlist';
  static const String routeCommentEdit = '/comment_edit';
  static const String routePlayerScreen = '/player_screen';
  static const String routeMixTapeSongs = 'mixtape_songs';
  static const String routeCommentListScreen = '/comment_list_screen';
  static const String routeReplyListScreen = '/reply_list_screen';
  static const String routeUploadSong = '/upload_song';
  static const String routeUploadAlbum = '/upload_screen';
  static const String routeCreatePlayList = '/create_playlist';
  static const String routeFilterEvent = '/filter_event';
  static const String routeResultEvent = '/result_event';
  static const String routeCalendarEvent = '/calendar_event';
  static const String routeEventMap = '/event_map';
  static const String routeAtlasFilter = '/atlas_filter';
  static const String routeAtlasFilterResult = '/atlas_filter_result';
  static const String routeEventDetail = '/route_event_detail';
  static const String routeCreateEvent = '/route_create_event';
  static const String routeMyDiaryOnMonth = '/my_diary_on_month';
  static const String routeProfile = '/route_profile';

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
        final SearchArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          TopSongScreen(
            arguments: arguments!,
          ),
        );
      case routeMixTapeSongs:
        final SearchArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          FeaturedMixTapesScreen(
            arguments: arguments!,
          ),
        );
      case routePlaceLocation:
        return _pageRoute(settings, const PlaceLocation());
      case routeEventDetail:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          EventDetail(
            id: arguments['event_id'] as int,
          ),
        );
      case routeMusicFilter:
        return _pageRoute(settings, const MusicFilterScreen());
      case routeDetailSong:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          DetailSongScreen(
            songId: arguments['song_id'] as String,
          ),
        );
      case routeResultEvent:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          ResultScreen(
            params: arguments['event_result'] as EventRequest,
          ),
        );
      case routeCreatePlayList:
        return _pageRoute(
          settings,
          const CreatePlayListScreen(),
        );
      case routeDetailAlbum:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          DetailAlbumScreen(
            albumId: arguments['album_id'] as String,
          ),
        );
      case routeEventMap:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          const MapScreen(),
        );
      case routeDetailPlayList:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          DetailPlayListScreen(
            playListId: arguments['playlist_id'] as String,
          ),
        );
      case routeCreateEvent:
        return _pageRoute(
          settings,
          const CreateEventScreen(),
        );
      case routeFeaturedAlbum:
        final SearchArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          FeaturedAlbumScreen(
            arguments: arguments!,
          ),
        );
      case routeFilterEvent:
        return _pageRoute(
          settings,
          const FilterEventScreen(),
        );
      case routeCalendarEvent:
        return _pageRoute(
          settings,
          const CalendarScreen(),
        );
      case routeCommentEdit:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          CommentEditScreen(
            argument: arguments['comment_response'] as CommentResponse,
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
      case routePlayerScreen:
        return _pageRoute(
          settings,
          PlayerScreen(
            params: asType(settings.arguments) as Map<String, dynamic>,
          ),
        );
      case routeCommentListScreen:
        final CommentArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          CommentListScreen(
            commentArgs: arguments!,
          ),
        );
      case routeReplyListScreen:
        final CommentArgs? arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          ReplyListScreen(
            commentArgs: arguments!,
          ),
        );
      case routeUploadSong:
        return _pageRoute(
          settings,
          UploadSongScreen(params: asType(settings.arguments) as Map<String, dynamic>),
        );
      case routeAtlasFilter:
        return _pageRoute(
          settings,
          ChangeNotifierProvider(
            create: (context) => AtlasFilterProvider(locator.get<AppRepository>()),
            child: const FilterAtlasScreen(),
          ),
        );
      case routeAtlasFilterResult:
        return _pageRoute(
          settings,
          AtlasFilterResultScreen(asType(settings.arguments) as FilterUsersRequest),
        );
      case routeMyDiaryOnMonth:
        return _pageRoute(
          settings,
          const MyDiaryInMonthScreen(),
      case routeProfile:
        return _pageRoute(
          settings,
          ProfileScreen(
            params: asType(settings.arguments) as Map<String, dynamic>,
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
