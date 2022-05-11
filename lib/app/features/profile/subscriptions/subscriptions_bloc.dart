import 'package:audio_cult/app/features/atlas/atlas_bloc.dart';

import '../../../data_source/repositories/app_repository.dart';

class SubscriptionsBloc extends AtlasBloc {
  final AppRepository _appRepository;

  SubscriptionsBloc(this._appRepository) : super(_appRepository);
}
