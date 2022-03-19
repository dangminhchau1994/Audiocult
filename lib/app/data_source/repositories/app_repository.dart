import 'package:audio_cult/app/data_source/models/cache_filter.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/models/responses/place.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/data_source/models/responses/song_detail/song_detail_response.dart';
import 'package:audio_cult/app/data_source/networks/exceptions/no_cache_exception.dart';
import 'package:audio_cult/app/data_source/services/hive_service_provider.dart';
import 'package:audio_cult/app/features/auth/widgets/register_page.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:dartz/dartz.dart';

import '../models/requests/login_request.dart';
import '../models/responses/login_response.dart';
import '../models/responses/register_response.dart';
import '../models/responses/song/song_response.dart';
import '../models/responses/user_group.dart';
import '../services/app_service_provider.dart';
import '../services/assets_local_provider.dart';
import '../services/place_service_provider.dart';
import 'base_repository.dart';

class AppRepository extends BaseRepository {
  final AppServiceProvider appServiceProvider;
  final PlaceServiceProvider placeServiceProvider;
  final HiveServiceProvider hiveServiceProvider;
  final AssetsLocalServiceProvider assetsLocalServiceProvider;

  AppRepository({
    required this.appServiceProvider,
    required this.placeServiceProvider,
    required this.hiveServiceProvider,
    required this.assetsLocalServiceProvider,
  });

  Future<Either<LoginResponse, Exception>> login(LoginRequest request) {
    return safeCall(() => appServiceProvider.login(request));
  }

  Future<Either<List<Song>, Exception>> getTopSongs(
    String sort,
    int page,
    int limit,
  ) {
    return safeCall(
      () => appServiceProvider.getTopSongs(sort, page, limit),
    );
  }

  Future<Either<List<Song>, Exception>> getSongsByAlbumId(
    int albumId,
    int page,
    int limit,
  ) {
    return safeCall(
      () => appServiceProvider.getSongsByAlbumId(albumId, page, limit),
    );
  }

  Future<Either<List<Song>, Exception>> getSongByPlaylistId(
    int playlistId,
    int page,
    int limit,
  ) {
    return safeCall(
      () => appServiceProvider.getSongsByPlaylistId(playlistId, page, limit),
    );
  }

  Future<Either<List<Album>, Exception>> getAlbums(
    String query,
    String view,
    int page,
    int limit,
  ) async {
    final albums = await safeCall(
      () async {
        final result = await appServiceProvider.getAlbums(query, view, page, limit);
        if (result.isNotEmpty) {
          hiveServiceProvider.saveAlbums(result);
        }
        return result;
      },
    );
    return albums.fold((l) {
      return left(l.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList());
    }, (r) {
      final localAlbum = hiveServiceProvider.getAlbum();

      if (localAlbum.isEmpty) {
        return right(NoCacheDataException(''));
      } else {
        return left(localAlbum);
      }
    });
  }

  Future<Either<Song, Exception>> getSongOfDay() {
    return safeCall(
      appServiceProvider.getSongOfDay,
    );
  }

  Future<Either<SongDetailResponse, Exception>> getSongDetail(int id) {
    return safeCall(
      () => appServiceProvider.getSongDetail(id),
    );
  }

  Future<Either<Album, Exception>> getAlbumDetail(int id) {
    return safeCall(
      () => appServiceProvider.getAlbumDetail(id),
    );
  }

  Future<Either<PlaylistResponse, Exception>> getPlayListDetail(int id) {
    return safeCall(
      () => appServiceProvider.getPlayListDetail(id),
    );
  }

  Future<Either<List<CommentResponse>, Exception>> getComments(int id, String typeId, int page, int limit) {
    return safeCall(
      () => appServiceProvider.getComments(id, typeId, page, limit),
    );
  }

  Future<Either<CommentResponse, Exception>> createComment(
    int itemId,
    String type,
    String text,
  ) {
    return safeCall(
      () => appServiceProvider.createComment(itemId, type, text),
    );
  }

  Future<Either<List<CommentResponse>, Exception>> getReplies(
    int parentId,
    int id,
    String typeId,
    int page,
    int limit,
  ) {
    return safeCall(
      () => appServiceProvider.getReplies(parentId, id, typeId, page, limit),
    );
  }

  Future<Either<CommentResponse, Exception>> createReply(
    int parentId,
    int itemId,
    String type,
    String text,
  ) {
    return safeCall(
      () => appServiceProvider.createReply(parentId, itemId, type, text),
    );
  }

  Future<Either<List<Song>, Exception>> getMixTapSongs(
    String sort,
    int page,
    int limit,
    String view,
    String type,
  ) {
    return safeCall(
      () => appServiceProvider.getMixTapSongs(sort, page, limit, view, type),
    );
  }

  Future<Either<List<PlaylistResponse>, Exception>> getPlaylists(
    String query,
    int page,
    int limit,
    String sort,
    int getAll,
  ) {
    return safeCall(
      () => appServiceProvider.getPlaylists(query, page, limit, sort, getAll),
    );
  }

  Future<Either<LoginResponse, Exception>> authentication() {
    return safeCall(appServiceProvider.authentication);
  }

  Future<Either<RegisterResponse, Exception>> register(RegisterRequest request) {
    return safeCall(() => appServiceProvider.register(request));
  }

  Future<Either<bool, Exception>> logout() {
    return safeCall(appServiceProvider.logout);
  }

  Future<Either<List<UserGroup>, Exception>> getRole(String? token) {
    return safeCall(() => appServiceProvider.getRole(token));
  }

  Future<Either<List<Suggestion>, Exception>> fetchSuggestions(String query, String languageCode) {
    return safeCall(() => placeServiceProvider.fetchSuggestions(query, languageCode));
  }

  Future<Either<Place?, Exception>> getPlaceDetailFromId(String placeId) {
    return safeCall(() => placeServiceProvider.getPlaceDetailFromId(placeId));
  }

  Future<Either<ProfileData?, Exception>> getUserProfile() async {
    final userProfile = await safeCall(appServiceProvider.getUserProfile);
    return userProfile.fold(
      (l) {
        hiveServiceProvider.saveProfile(l);
        return left(ProfileData.fromJson(l as Map<String, dynamic>));
      },
      (r) {
        final profile = hiveServiceProvider.getProfile();
        if (profile != null) {
          return left(profile);
        } else {
          return right(NoCacheDataException(''));
        }
      },
    );
  }

  void clearProfile() {
    hiveServiceProvider.clearProfile();
  }

  Future<Map<String, List<SelectMenuModel>>> getMasterDataFilter() {
    return assetsLocalServiceProvider.getMasterDataFilter();
  }

  Future<Either<List<Genre>, Exception>> getGenres() async {
    final genres = await safeCall(appServiceProvider.getGenres);
    return genres.fold(
      (l) {
        hiveServiceProvider.saveGenres(l);
        return left(l.map((e) => Genre.fromJson(e as Map<String, dynamic>)).toList());
      },
      (r) {
        final local = hiveServiceProvider.getGenres();
        if (local.isNotEmpty) {
          return left(local);
        } else {
          return right(NoCacheDataException(''));
        }
      },
    );
  }

  CacheFilter? getCacheFilter() {
    final result = hiveServiceProvider.getCacheFilter();
    return result;
  }

  Future saveCacheFilter(CacheFilter cacheFilter) async {
    hiveServiceProvider.saveCacheFilter(cacheFilter);
  }

  Future clearFilter() async {
    await hiveServiceProvider.clearFilter();
  }
}
