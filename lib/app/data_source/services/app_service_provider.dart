import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/login_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song_detail/song_detail_response.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';

import '../../utils/extensions/app_extensions.dart';
import '../models/base_response.dart';
import '../models/requests/login_request.dart';
import '../models/responses/profile_data.dart';
import '../models/responses/register_response.dart';
import '../models/responses/song/song_response.dart';
import '../models/responses/user_group.dart';
import '../networks/core/dio_helper.dart';
import '../networks/core/handler/app_response_handler.dart';

class AppServiceProvider {
  late DioHelper _dioHelper;

  AppServiceProvider(Dio dio) {
    _dioHelper = DioHelper(dio, responseHandler: AppResponseHandler());
  }

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dioHelper.post(
      route: '/restful_api/token',
      requestBody: request.toJson(),
    );
    return LoginResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<LoginResponse> authentication() async {
    final response = await _dioHelper.post(
      isAuthRequired: false,
      options: Options(headers: {'Authorization': AppConstants.basicToken}),
      requestBody: FormData.fromMap({'grant_type': 'client_credentials'}),
      route: '/restful_api/token',
    );
    return LoginResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: request.toJson(),
    );
    final data = BaseRes.fromJson(response as Map<String, dynamic>);
    if (data.status == StatusString.success) {
      return RegisterResponse(
        // ignore: cast_nullable_to_non_nullable
        status: data.status as String, data: ProfileData.fromJson(data.data as Map<String, dynamic>),
      );
    } else {
      return RegisterResponse(status: data.status as String, message: data.error['message'] as String);
    }
  }

  Future<List<dynamic>> getAlbums(String query, String view, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/album',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'search[search]': query,
        'view': view,
        'page': page,
        'limit': limit,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json),
    );
    // response.mapData(
    //   (json) => asType<List<dynamic>>(json)?.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList(),
    // );
  }

  Future<List<PlaylistResponse>> getPlaylists(String query, int page, int limit, String sort, int getAll) async {
    final response = await _dioHelper.get(
      route: '/restful_api/playlist',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'search[search]': query,
        'page': page,
        'limit': limit,
        'sort': sort,
        'get_all': getAll,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => PlaylistResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<Song>> getMixTapSongs(
    String sort,
    int page,
    int limit,
    String view,
    String type,
  ) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'sort': sort,
        'page': page,
        'limit': limit,
        'view': view,
        'type': type,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<Song>> getTopSongs(String sort, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'sort': sort,
        'page': page,
        'limit': limit,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<Song>> getSongsByAlbumId(int albumId, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'album_id': albumId,
        'page': page,
        'limit': limit,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<Song>> getSongsByPlaylistId(int playlistId, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'playlist_id': playlistId,
        'page': page,
        'limit': limit,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<SongDetailResponse> getSongDetail(int id) async {
    final response = await _dioHelper.get(
      route: '/restful_api/music/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => SongDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<Song> getSongOfDay() async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/song-of-day',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => Song.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<CommentResponse>> getComments(int id, String typeId, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'item_id': id,
        'type_id': typeId,
        'page': page,
        'limit': limit,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<CommentResponse> createComment(
    int itemId,
    String type,
    String text,
  ) async {
    final response = await _dioHelper.post(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap({
        'val[item_id]': itemId,
        'val[type]': type,
        'val[text]': text,
      }),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => CommentResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<CommentResponse>> getReplies(int parentId, int itemId, String typeId, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'parent_id': parentId,
        'item_id': itemId,
        'type_id': typeId,
        'page': page,
        'limit': limit,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<ReactionIconResponse>> getReactionIcons() async {
    final response = await _dioHelper.get(
      route: '/restful_api/like/icon',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) =>
          asType<List<dynamic>>(json)?.map((e) => ReactionIconResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<CommentResponse> postReactionIcon(String typeId, int itemId, int likeType) async {
    final response = await _dioHelper.post(
      route: '/restful_api/like/item',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap({
        'type_id': typeId,
        'item_id': itemId,
        'like_type': likeType,
      }),
    );
    return response.mapData(
      (json) => CommentResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<CommentResponse> createReply(
    int parentId,
    int itemId,
    String type,
    String text,
  ) async {
    final response = await _dioHelper.post(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap({
        'val[parent_id]': parentId,
        'val[item_id]': itemId,
        'val[type]': type,
        'val[text]': text,
      }),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => CommentResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<Album> getAlbumDetail(int id) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/album/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => Album.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<PlaylistResponse> getPlayListDetail(int id) async {
    final response = await _dioHelper.get(
      route: '/restful_api/playlist/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => PlaylistResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<bool> logout() async {
    final pref = locator.get<PrefProvider>();
    final response = await _dioHelper.post(
      isAuthRequired: false,
      requestBody: FormData.fromMap(
        {'client_id': AppConstants.clientId, 'client_secret': AppConstants.clientSecret, 'token': pref.accessToken},
      ),
      route: '/restful_api/revoke',
    );
    return response['revoked'] as bool;
  }

  Future<List<UserGroup>> getRole(String? token) async {
    final response = await _dioHelper.get(
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      route: '/restful_api/user/groups',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => UserGroup.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<dynamic> getUserProfile() async {
    final response = await _dioHelper.get(
      route: '/restful_api/user/mine',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<List<dynamic>> getGenres() async {
    final response = await _dioHelper.get(
      route: '/restful_api/music/genre',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json),
    );
  }
}
