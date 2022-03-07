import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:audio_cult/app/data_source/models/responses/login_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
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

  Future<List<dynamic>> getAlbums(String view, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/album',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
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

  Future<List<PlaylistResponse>> getPlaylists(int page, int limit, String sort, int getAll) async {
    final response = await _dioHelper.get(
      route: '/restful_api/playlist',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
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
}
