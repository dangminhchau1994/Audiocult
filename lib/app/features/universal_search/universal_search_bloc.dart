import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class UniversalSearchBloc extends BaseBloc {
  final AppRepository _appRepo;

  UniversalSearchBloc(this._appRepo);
}
