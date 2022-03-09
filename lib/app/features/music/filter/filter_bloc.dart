import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/cache_filter.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data_source/repositories/app_repository.dart';

class FilterBloc extends BaseBloc {
  final AppRepository _appRepository;
  final _getMasterDataSubject = PublishSubject<Map<String, List<SelectMenuModel>>>();
  final _getGenresSubject = PublishSubject<List<Genre>>();

  Stream<Map<String, List<SelectMenuModel>>> get getMasterDataStream => _getMasterDataSubject.stream;
  Stream<List<Genre>> get getGenresStream => _getGenresSubject.stream;

  FilterBloc(this._appRepository);

  void getMasterData() async {
    final result = await _appRepository.getMasterDataFilter();
    _getMasterDataSubject.add(result);
  }

  void getGenres() async {
    final result = await _appRepository.getGenres();
    result.fold(_getGenresSubject.add, (r) => _getGenresSubject.add([]));
  }

  CacheFilter? cache() {
    final cache = _appRepository.getCacheFilter();
    return cache;
  }

  void clearFilter() async {
    await _appRepository.clearFilter();
  }

  void getCacheFilter() async {
    final cache = _appRepository.getCacheFilter();
    if (cache == null) {
      getMasterData();
      getGenres();
      return null;
    } else {
      final masterData = await _appRepository.getMasterDataFilter();
      final temp = <String, List<SelectMenuModel>>{};
      if (cache.mostLiked!.isNotEmpty) {
        temp['most_liked'] = cache.mostLiked!;
      } else {
        temp['most_liked'] = masterData['most_liked']!;
      }
      if (cache.allTime!.isNotEmpty) {
        temp['all_time'] = cache.allTime!;
      } else {
        temp['all_time'] = masterData['all_time']!;
      }
      _getMasterDataSubject.add(temp);
      if (cache.genres!.isNotEmpty) {
        _getGenresSubject.add(cache.genres!);
      } else {
        getGenres();
      }
    }
  }

  void saveCacheFilter(CacheFilter cacheFilter) async {
    await _appRepository.saveCacheFilter(cacheFilter);
  }
}
