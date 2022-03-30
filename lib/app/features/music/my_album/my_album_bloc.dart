import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

import '../discover/discover_bloc.dart';

class MyAlbumBloc extends DiscoverBloc {
  MyAlbumBloc(AppRepository appRepository) : super(appRepository);
}
