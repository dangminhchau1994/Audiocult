import 'package:audio_cult/app/data_source/models/base_response.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_request.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/data_source/networks/exceptions/app_exception.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/base_bloc.dart';
import '../../../../data_source/local/pref_provider.dart';
import '../../../../data_source/models/responses/genre.dart';
import '../../../../data_source/repositories/app_repository.dart';
import '../../../main/main_bloc.dart';

class UploadSongBloc extends MainBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;

  UploadSongBloc(this._appRepository, this._prefProvider) : super(_appRepository, _prefProvider);
  final _getGenresSubject = PublishSubject<List<Genre>>();
  final _uploadSubject = PublishSubject<String>();

  Stream<List<Genre>> get getGenresStream => _getGenresSubject.stream;
  Stream<String> get uploadStream => _uploadSubject.stream;

  void getGenres() async {
    final result = await _appRepository.getGenres();
    result.fold(_getGenresSubject.add, (r) => _getGenresSubject.add([]));
  }

  Future<List<ProfileData>> getListUsers(String query, String? groupUserId) async {
    final result = await _appRepository.getListUsers(query, groupUserId);
    return result.fold((l) => l, (r) => []);
  }

  void uploadSong(UploadRequest resultStep2) async {
    showOverLayLoading();
    final result = await _appRepository.uploadSong(resultStep2);
    hideOverlayLoading();
    result.fold(
      (l) {
        if (l.status == StatusString.success) {
          _uploadSubject.add(l.message ?? 'Success!');
        } else {
          showError(AppException(l.message));
        }
      },
      showError,
    );
  }
}
