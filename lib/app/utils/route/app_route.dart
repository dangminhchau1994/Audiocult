import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/features/atlas/subscribe_user_bloc.dart';
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
import 'package:audio_cult/app/features/events/my_tickets_of_event/my_tickets_of_event_screen.dart';
import 'package:audio_cult/app/features/events/result/result_screen.dart';
import 'package:audio_cult/app/features/home/edit_feed/edit_feed_screen.dart';
import 'package:audio_cult/app/features/home/home_create_post.dart';
import 'package:audio_cult/app/features/main/main_screen.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_screen.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_screen.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_screen.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_screen.dart';
import 'package:audio_cult/app/features/music/featured_mixtape/featured_mixtapes_screen.dart';
import 'package:audio_cult/app/features/music/filter/enum_filter_music.dart';
import 'package:audio_cult/app/features/music/filter/music_filter_screen.dart';
import 'package:audio_cult/app/features/music/library/create_playlist_screen.dart';
import 'package:audio_cult/app/features/music/library/library_bloc.dart';
import 'package:audio_cult/app/features/music/library/library_screen.dart';
import 'package:audio_cult/app/features/music/library/update_playlist_params.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_screen.dart';
import 'package:audio_cult/app/features/music/top_playlist/top_playlist_screen.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_screen.dart';
import 'package:audio_cult/app/features/my_diary_in_month/my_diary_in_month_screen.dart';
import 'package:audio_cult/app/features/notifications/notification_screen.dart';
import 'package:audio_cult/app/features/player_widgets/player_screen.dart';
import 'package:audio_cult/app/features/profile/profile_bloc.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/features/profile/subscriptions/subscriptions_screen.dart';
import 'package:audio_cult/app/features/search_suggestion/search_suggestion_screen.dart';
import 'package:audio_cult/app/features/settings/account_settings/delete_account_screen.dart';
import 'package:audio_cult/app/features/settings/settings_screen.dart';
import 'package:audio_cult/app/features/terms/terms_screen.dart';
import 'package:audio_cult/app/features/ticket/my_cart/my_cart_ticket.dart';
import 'package:audio_cult/app/features/ticket/payments/payment_tickets_screen.dart';
import 'package:audio_cult/app/features/ticket/payments/ticket_cart_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_screen.dart';
import 'package:audio_cult/app/features/videos/video_player_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_edit_screen.dart';
import 'package:audio_cult/w_components/comment/comment_list_screen.dart';
import 'package:audio_cult/w_components/comment/reply_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../data_source/models/responses/video_data.dart';
import '../../features/auth/create_new_password/create_new_password_screen.dart';
import '../../features/events/map/map_screen.dart';
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
  static const String routeCreatePost = '/create_post';
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
  static const String routeSettings = '/route_settings';
  static const String routeDeleteAccount = '/route_delete_account';
  static const String routeSubscriptions = '/route_subscriptions';
  static const String routeVideoPlayer = '/route_video_player';
  static const String routeNotification = '/route_notification';
  static const String routeResetPassword = '/route_reset_password';
  static const String routeUniversalSearch = '/route_universal_search';
  static const String routeSearchSuggestion = '/route_search_suggestion';
  static const String routeMyCart = '/route_my_cart';
  static const String routeEditFeed = '/route_edit_feed';
  static const String routeTerms = '/route_terms';
  static const String routeLibrary = '/route_library';
  static const String routePaymentTicket = '/route_payment_ticket';
  static const String routeTicketCart = '/route_ticket_cart';
  static const String routeMyCartTicket = '/route_my_cart_ticket';
  static const String routeMyTicketsOfEvent = '/my_tickets_of_event';

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
        final arguments = asType(settings.arguments);
        return _pageRoute(
            settings,
            MainScreen(
              fromPayment: arguments != null,
            ));
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

      case routeLibrary:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          Provider(
            create: (context) => LibraryBloc(locator.get()),
            child: LibraryScreen(
              hasAppBar: arguments['has_app_bar'] as bool,
              songId: arguments['song_id'] as String,
            ),
          ),
        );

      case routeEditFeed:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          EditFeedScreen(
            data: arguments['feed_response'] as FeedResponse,
            eventId: arguments['event_id'] != null ? arguments['event_id'] as int : null,
            fromEvent: arguments['from_event'] != null ? arguments['from_event'] as bool : null,
          ),
        );

      case routeDeleteAccount:
        return _pageRoute(
          settings,
          const DeleteAccountScreen(),
        );

      case routeTerms:
        return _pageRoute(
          settings,
          const TermsScreen(),
        );

      case routeNotification:
        return _pageRoute(
          settings,
          const NotificationScreen(),
        );
      case routePlaceLocation:
        return _pageRoute(settings, const PlaceLocation());
      case routeEventDetail:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          EventDetail(
            id: arguments['event_id'] as int,
            // ignore: avoid_bool_literals_in_conditional_expressions
            fromNotificatiton: arguments['from_notification'] == null ? false : true,
          ),
        );
      case routeMusicFilter:
        final arguments = asType(settings.arguments);
        return _pageRoute(
            settings,
            MusicFilterScreen(
              typeFilterMusic: arguments as TypeFilterMusic?,
            ));
      case routeDetailSong:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          DetailSongScreen(
            songId: arguments['song_id'] as String,
            // ignore: avoid_bool_literals_in_conditional_expressions
            fromNotificatiton: arguments['from_notification'] == null ? false : true,
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
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          CreatePlayListScreen(
            updatePlaylistParams: arguments['update_playlist_params'] as UpdatePlaylistParams,
          ),
        );
      case routeDetailAlbum:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          DetailAlbumScreen(
            albumId: arguments['album_id'] as String,
            // ignore: avoid_bool_literals_in_conditional_expressions
            fromNotificatiton: arguments['from_notification'] == null ? false : true,
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
      case routeCreatePost:
        final arguments = asType(settings.arguments);
        return _pageRoute(
          settings,
          HomeCreatePost(
            eventId: arguments['event_id'] != null ? arguments['event_id'] as int : null,
            userId: arguments['user_id'] != null ? arguments['user_id'] as String? : null,
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
            create: (context) => AtlasFilterProvider(
              locator.get<AppRepository>(),
              filterRequest: settings.arguments as FilterUsersRequest?,
            ),
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
          MyDiaryInMonthScreen(myDiaryParams: asType<MyDiaryEventRequest>(settings.arguments)),
        );
      case routeProfile:
        return _pageRoute(
          settings,
          Provider<ProfileBloc>(
            create: (context) => ProfileBloc(locator.get(), locator.get<SubscribeUserBloc>()),
            dispose: (context, bloc) => bloc.dispose(),
            child: ProfileScreen(
              params: asType(settings.arguments) as Map<String, dynamic>,
            ),
          ),
        );
      case routeSettings:
        return _pageRoute(settings, const SettingsScreen());
      case routeSubscriptions:
        final arguments = asType(settings.arguments);
        return _pageRoute(
            settings,
            SubscriptionsScreen(
              userId: arguments['user_id'] as String?,
              title: arguments['title'] as String?,
              getSubscribed: arguments['get_subscribed'] != null ? arguments['get_subscribed'] as String? : null,
            ));
      case routeVideoPlayer:
        final arguments = asType(settings.arguments);

        return _pageRoute(
            settings,
            VideoPlayerScreen(
              data: arguments['data'] as Video,
            ));
      case routeResetPassword:
        final arguments = asType(settings.arguments);

        return _pageRoute(
            settings,
            CreateNewPasswordScreen(
              codeSent: arguments as String?,
            ));
      case routeUniversalSearch:
        return _pageRoute(settings, const UniversalSearchScreen());
      case routeSearchSuggestion:
        final arguments = asType(settings.arguments);
        return _pageRoute(settings, SearchSuggestionScreen(initialSearchText: arguments as String?));
      case routeMyCart:
        return _pageRoute(settings, const MyCartScreen());
      case routePaymentTicket:
        return _pageRoute(
            settings,
            PaymentTicketsScreen(
              params: asType(settings.arguments) as Map<String, dynamic>,
            ));
      case routeTicketCart:
        return _pageRoute(
            settings,
            TicketCartScreen(
              params: asType(settings.arguments) as Map<String, dynamic>,
            ));
      case routeMyCartTicket:
        return _pageRoute(
            settings,
            MyCartTicket(
              params: asType(settings.arguments) as Map<String, dynamic>,
            ));
      case routeMyTicketsOfEvent:
        final event = asType<EventResponse>(settings.arguments)!;
        return _pageRoute(settings, MyTicketsOfEventScreen(event));
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
