import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data_source/models/base_response.dart';
import '../../../data_source/networks/exceptions/app_exception.dart';
import '../discover/discover_bloc.dart';

class MyAlbumBloc extends DiscoverBloc {
  final AppRepository _appRepository;
  final _deleteSubject = PublishSubject<String>();
  final _deleteAlbumSubject = PublishSubject<String>();

  Stream<String> get deleteStream => _deleteSubject.stream;
  Stream<String> get deleteAlbumStream => _deleteAlbumSubject.stream;
  MyAlbumBloc(this._appRepository) : super(_appRepository);

  void deleteSongId(String? songId) async {
    showOverLayLoading();
    final result = await _appRepository.deleteSongId(songId);
    hideOverlayLoading();
    result.fold(
      (l) {
        if (l.status == StatusString.success) {
          _deleteSubject.add(l.data ?? 'Song successfully deleted.');
        } else {
          showError(AppException(l.message));
        }
      },
      showError,
    );
  }

  void deletedAlbum(String? albumId) async {
    showOverLayLoading();
    final result = await _appRepository.deletedAlbumId(albumId);
    hideOverlayLoading();
    result.fold(
      (l) {
        if (l.status == StatusString.success) {
          _deleteAlbumSubject.add(l.data ?? 'Album successfully deleted.');
        } else {
          showError(AppException(l.message));
        }
      },
      showError,
    );
  }
}
