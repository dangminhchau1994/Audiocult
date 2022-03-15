import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_bloc.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_bloc.dart';
import 'package:audio_cult/app/features/music/search/search_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:get_it/get_it.dart';
import '../app/features/main/main_bloc.dart';
import '../app/features/music/discover/discover_bloc.dart';
import '../app/features/music/top_playlist/top_playlist_bloc.dart';
import '../app/features/music/top_song/top_song_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<MainBloc>(() => MainBloc(locator.get<AppRepository>(), locator.get<PrefProvider>()));

  getIt.registerLazySingleton<TopSongBloc>(() => TopSongBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DiscoverBloc>(() => DiscoverBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<SearchBloc>(() => SearchBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<FeaturedAlbumBloc>(() => FeaturedAlbumBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<TopPlaylistBloc>(() => TopPlaylistBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DetailSongBloc>(() => DetailSongBloc(locator.get<AppRepository>()));
}
