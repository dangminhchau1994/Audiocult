import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/responses/language_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/data_source/services/app_service_provider.dart';
import 'package:audio_cult/app/data_source/services/assets_local_provider.dart';
import 'package:audio_cult/app/data_source/services/language_provider.dart';
import 'package:audio_cult/app/fcm/fcm_bloc.dart';
import 'package:audio_cult/app/features/atlas/atlas_bloc.dart';
import 'package:audio_cult/app/features/atlas/subscribe_user_bloc.dart';
import 'package:audio_cult/app/features/atlas_filter_result/atlas_filter_result_bloc.dart';
import 'package:audio_cult/app/features/events/all_event_bloc.dart';
import 'package:audio_cult/app/features/events/calendar/calendar_bloc.dart';
import 'package:audio_cult/app/features/events/detail/event_detail_bloc.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_bloc.dart';
import 'package:audio_cult/app/features/events/my_tickets/my_tickets_bloc.dart';
import 'package:audio_cult/app/features/events/my_tickets_of_event/my_tickets_of_event_bloc.dart';
import 'package:audio_cult/app/features/events/result/result_bloc.dart';
import 'package:audio_cult/app/features/home/edit_feed/edit_feed_bloc.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/music/albums/albums_bloc.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_bloc.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_bloc.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_bloc.dart';
import 'package:audio_cult/app/features/music/featured_mixtape/featured_mixtapes_bloc.dart';
import 'package:audio_cult/app/features/music/library/create_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/playlist_dialog_bloc.dart';
import 'package:audio_cult/app/features/music/search/search_bloc.dart';
import 'package:audio_cult/app/features/music/songs/songs_bloc.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_bloc.dart';
import 'package:audio_cult/app/features/my_diary_in_month/my_diary_in_month_bloc.dart';
import 'package:audio_cult/app/features/notifications/notification_bloc.dart';
import 'package:audio_cult/app/features/search_suggestion/search_suggestion_bloc.dart';
import 'package:audio_cult/app/features/settings/account_settings/account_settings_bloc.dart';
import 'package:audio_cult/app/features/settings/notifications_settings/notification_settings_bloc.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_bloc.dart';
import 'package:audio_cult/app/features/settings/privacy_settings/privacy_settings_bloc.dart';
import 'package:audio_cult/app/features/universal_search/universal_seach_bloc.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_results_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/localized_widget_wrapper/language_bloc.dart';
import 'package:audio_cult/w_components/comment/reply_list_bloc.dart';
import 'package:get_it/get_it.dart';
import '../app/features/events/map/map_bloc.dart';
import '../app/features/events/popular_event_bloc.dart';
import '../app/features/main/main_bloc.dart';
import '../app/features/music/discover/discover_bloc.dart';
import '../app/features/music/top_playlist/top_playlist_bloc.dart';
import '../app/features/music/top_song/top_song_bloc.dart';
import '../w_components/comment/comment_list_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<MainBloc>(
    () => MainBloc(
      locator.get<AppRepository>(),
      locator.get<PrefProvider>(),
      languageBloc: locator.get<LanguageBloc>(),
    ),
  );

  getIt.registerLazySingleton<TopSongBloc>(() => TopSongBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DiscoverBloc>(() => DiscoverBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<SearchBloc>(() => SearchBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<FeaturedAlbumBloc>(() => FeaturedAlbumBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<TopPlaylistBloc>(() => TopPlaylistBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DetailSongBloc>(
      () => DetailSongBloc(locator.get<AppRepository>(), locator.get<MyCartBloc>()));

  getIt.registerLazySingleton<DetailAlbumBloc>(() => DetailAlbumBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DetailPlayListBloc>(() => DetailPlayListBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<EventDetailBloc>(() => EventDetailBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<CommentListBloc>(
    () => CommentListBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<ReplyListBloc>(
    () => ReplyListBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<FCMBloc>(FCMBloc.new);

  getIt.registerLazySingleton<FeaturedMixtapesBloc>(
    () => FeaturedMixtapesBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<CreatePlayListBloc>(
    () => CreatePlayListBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<PlayListDialogBloc>(
    () => PlayListDialogBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<AllEventBloc>(
    () => AllEventBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<EditFeedBloc>(
    () => EditFeedBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<ResultBloc>(
    () => ResultBloc(locator.get<AppRepository>()),
  );
  getIt.registerFactory<AtlasBloc>(() => AtlasBloc(
        locator.get<AppRepository>(),
        locator.get<SubscribeUserBloc>(),
        locator.get<PrefProvider>(),
      ));

  getIt.registerLazySingleton<CalendarBloc>(
    () => CalendarBloc(locator.get<AppRepository>(), locator.get<PrefProvider>()),
  );

  getIt.registerLazySingleton<PopularEventBloc>(
    () => PopularEventBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<MapBloc>(
    () => MapBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<SongsBloc>(
    () => SongsBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<AlbumsBloc>(
    () => AlbumsBloc(locator.get<AppRepository>()),
  );

  getIt.registerFactory<AtlasFilterResultBloc>(
    () => AtlasFilterResultBloc(
      locator.get<AppRepository>(),
      locator.get<SubscribeUserBloc>(),
    ),
  );

  getIt.registerFactory<MyDiaryBloc>(
    () => MyDiaryBloc(
      locator.get<AppRepository>(),
      locator.get<PrefProvider>(),
    ),
  );

  getIt.registerFactory<MyDiaryInMonthBloc>(() => MyDiaryInMonthBloc(locator.get<AppRepository>()));

  getIt.registerFactory<PageTemplateBloc>(
      () => PageTemplateBloc(locator.get<AppRepository>(), locator.get<PrefProvider>()));

  getIt.registerLazySingleton<HomeBloc>(
    () => HomeBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<NotificationBloc>(
    () => NotificationBloc(locator.get<AppRepository>()),
  );

  getIt.registerFactory<AccountSettingsBloc>(
    () => AccountSettingsBloc(
      locator.get<AppRepository>(),
      locator.get<PrefProvider>(),
      locator.get<LanguageBloc>(),
    ),
  );

  getIt.registerFactory<NotificationSettingsBloc>(() => NotificationSettingsBloc(locator.get<AppRepository>()));

  getIt.registerFactory<PrivacySettingsBloc>(() => PrivacySettingsBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<SubscribeUserBloc>(SubscribeUserBloc.new);

  getIt.registerFactory<UniversalSearchResultsBloc>(() => UniversalSearchResultsBloc(locator.get<AppRepository>()));

  getIt.registerFactory<UniversalSearchBloc>(() => UniversalSearchBloc(locator.get<AppRepository>()));

  getIt.registerFactory<SearchSuggestionBloc>(SearchSuggestionBloc.new);

  getIt.registerFactory<MyTicketsOfEventBloc>(() => MyTicketsOfEventBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton(() => MyCartBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton(
    () => LanguageBloc(
      prefProvider: locator.get<PrefProvider>(),
      localizedTextProvider: locator.get<LanguageProvider>(),
    ),
  );

  getIt.registerLazySingleton(() => MyTicketsBloc(locator.get<AppRepository>()));
}
