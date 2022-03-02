import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:get_it/get_it.dart';

import '../app/features/main/main_bloc.dart';
import '../app/features/music/discover/discover_bloc.dart';
import '../app/features/music/top_song/top_song_bloc.dart';


final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<MainBloc>(() => MainBloc(locator.get<AppRepository>(), locator.get<PrefProvider>()));

  getIt.registerLazySingleton<TopSongBloc>(() => TopSongBloc(locator.get<AppRepository>()));

  getIt.registerLazySingleton<DiscoverBloc>(() => DiscoverBloc(locator.get<AppRepository>()));
}
