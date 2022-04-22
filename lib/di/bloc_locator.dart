import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/features/atlas/atlas_bloc.dart';
import 'package:audio_cult/app/features/atlas_filter_result/atlas_filter_result_bloc.dart';
import 'package:audio_cult/app/features/events/all_event_bloc.dart';
import 'package:audio_cult/app/features/events/calendar/calendar_bloc.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_bloc.dart';
import 'package:audio_cult/app/features/events/result/result_bloc.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_bloc.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_bloc.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_bloc.dart';
import 'package:audio_cult/app/features/music/featured_mixtape/featured_mixtapes_bloc.dart';
import 'package:audio_cult/app/features/music/library/create_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/playlist_dialog_bloc.dart';
import 'package:audio_cult/app/features/music/search/search_bloc.dart';
import 'package:audio_cult/app/features/my_diary_in_month/my_diary_in_month_bloc.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/w_components/comment/comment_item_bloc.dart';
import 'package:audio_cult/w_components/comment/reply_list_bloc.dart';
import 'package:get_it/get_it.dart';

import '../app/features/events/map/map_bloc.dart';
import '../app/features/events/popular_event_bloc.dart';
import '../app/features/main/main_bloc.dart';
import '../app/features/music/discover/discover_bloc.dart';
import '../app/features/music/library/library_bloc.dart';
import '../app/features/music/top_playlist/top_playlist_bloc.dart';
import '../app/features/music/top_song/top_song_bloc.dart';
import '../w_components/comment/comment_list_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<MainBloc>(() => MainBloc(locator.get<AppRepository>(), locator.get<PrefProvider>()));

  getIt.registerLazySingleton<TopSongBloc>(() => TopSongBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DiscoverBloc>(() => DiscoverBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<SearchBloc>(() => SearchBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<FeaturedAlbumBloc>(() => FeaturedAlbumBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<TopPlaylistBloc>(() => TopPlaylistBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DetailSongBloc>(() => DetailSongBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DetailAlbumBloc>(() => DetailAlbumBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DetailPlayListBloc>(() => DetailPlayListBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<CommentListBloc>(
    () => CommentListBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<ReplyListBloc>(
    () => ReplyListBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<CommentItemBloc>(
    () => CommentItemBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<FeaturedMixtapesBloc>(
    () => FeaturedMixtapesBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<CreatePlayListBloc>(
    () => CreatePlayListBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<LibraryBloc>(
    () => LibraryBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<PlayListDialogBloc>(
    () => PlayListDialogBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<AllEventBloc>(
    () => AllEventBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<ResultBloc>(
    () => ResultBloc(locator.get<AppRepository>()),
  );
  getIt.registerFactory<AtlasBloc>(() => AtlasBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<CalendarBloc>(
    () => CalendarBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<PopularEventBloc>(
    () => PopularEventBloc(locator.get<AppRepository>()),
  );

  getIt.registerLazySingleton<MapBloc>(
    () => MapBloc(locator.get<AppRepository>()),
  );
  getIt.registerFactory<AtlasFilterResultBloc>(() => AtlasFilterResultBloc(locator.get<AppRepository>()));

  getIt.registerFactory<MyDiaryBloc>(() => MyDiaryBloc(locator.get<AppRepository>()));

  getIt.registerFactory<MyDiaryInMonthBloc>(() => MyDiaryInMonthBloc(locator.get<AppRepository>()));

  getIt.registerFactory<PageTemplateBloc>(() => PageTemplateBloc(locator.get<AppRepository>()));
}
