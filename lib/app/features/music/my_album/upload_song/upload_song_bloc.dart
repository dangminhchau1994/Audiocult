import 'package:rxdart/rxdart.dart';

import '../../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../base/base_bloc.dart';
import '../../../../data_source/models/responses/genre.dart';
import '../../../../data_source/repositories/app_repository.dart';

class UploadSongBloc extends BaseBloc {
  final AppRepository _appRepository;
  UploadSongBloc(this._appRepository);
  final _getMasterDataSubject = PublishSubject<Map<String, List<SelectMenuModel>>>();
  final _getGenresSubject = PublishSubject<List<Genre>>();

  Stream<List<Genre>> get getGenresStream => _getGenresSubject.stream;

  void getGenres() async {
    final result = await _appRepository.getGenres();
    result.fold(_getGenresSubject.add, (r) => _getGenresSubject.add([]));
  }
}
