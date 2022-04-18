import 'dart:io';

import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_request.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_category.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/data_source/models/responses/create_playlist/create_playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/models/responses/login_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song_detail/song_detail_response.dart';
import 'package:audio_cult/app/data_source/models/responses/user_subscription_response.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';

import '../../utils/extensions/app_extensions.dart';
import '../models/base_response.dart';
import '../models/requests/login_request.dart';
import '../models/responses/atlas_user.dart';
import '../models/responses/create_album_response.dart';
import '../models/responses/events/event_category_response.dart';
import '../models/responses/profile_data.dart';
import '../models/responses/register_response.dart';
import '../models/responses/song/song_response.dart';
import '../models/responses/user_group.dart';
import '../networks/core/dio_helper.dart';
import '../networks/core/handler/app_response_handler.dart';

class AppServiceProvider {
  late DioHelper _dioHelper;
  List<AtlasCategory>? _atlasCategories;
  List<Country>? _countries;

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

  Future<PlaylistResponse> addToPlayList(
    String playListId,
    String songId,
  ) async {
    final response = await _dioHelper.post(
      route: '/restful_api/playlist/add_to_playlist',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap({
        'val[playlist_id]': playListId,
        'val[song_id]': songId,
      }),
    );
    return response.mapData(
      (json) => PlaylistResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<EventResponse> getEventDetail(int id) async {
    final response = await _dioHelper.get(
      route: '/restful_api/event/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => EventResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<EventResponse>> updateEventStatus(int eventId, int rsvp) async {
    final response = await _dioHelper.put(
      route: '/restful_api/advancedevent/$eventId/rsvp',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: {'rsvp': rsvp},
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => EventResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<EventResponse>> getEvents(EventRequest request) async {
    final response = await _dioHelper.get(
      route: '/restful_api/event',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestParams: {
        'search[search]': request.query,
        'postal_code': request.postalCode,
        'location': request.location,
        'country_iso': request.countryIso,
        'view': request.view,
        'distance': request.distance,
        'when': request.when,
        'start_time': request.startTime,
        'end_time': request.endTime,
        'sort': request.sort,
        'page': request.page,
        'limit': request.limit,
      },
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => EventResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user',
      isAuthRequired: false,
      options: Options(headers: {
        'authorization': 'Bearer ${request.accessToken}',
      }),
      requestBody: FormData.fromMap(request.toJson()),
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

  Future<List<dynamic>> getAlbums(String query, String view, int page, int limit, {String? userId}) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/album',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {'search[search]': query, 'view': view, 'page': page, 'limit': limit, 'user_id': userId},
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
    String query,
    String sort,
    int page,
    int limit,
    String view,
    String type, {
    String? userId,
    String? albumId,
  }) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'search[search]': query,
        'sort': sort,
        'page': page,
        'limit': limit,
        'view': view,
        'type': type,
        'user_id': userId,
        'album_id': albumId
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<Song>> getTopSongs(String query, String sort, int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'search[search]': query,
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

  Future<CreatePlayListResponse> createPlayList(String name, File image) async {
    final response = await _dioHelper.post(
      route: '/restful_api/playlist',
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap({
        'val[title]': name,
        'image': await MultipartFile.fromFile(image.path),
      }),
    );
    return response.mapData(
      (json) => CreatePlayListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<EventCategoryResponse>> getEventCategories() async {
    final response = await _dioHelper.get(
      route: '/restful_api/event/category',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData((json) =>
        asType<List<dynamic>>(json)?.map((e) => EventCategoryResponse.fromJson(e as Map<String, dynamic>)).toList());
  }

  Future<EventResponse> createEvent(CreateEventRequest request) async {
    var imageFile;

    if (request.image != null) {
      imageFile = await MultipartFile.fromFile(request.image?.path ?? '');
    }
    final response = await _dioHelper.post(
      route: '/restful_api/event',
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap({
        'val[category]': request.categoryId,
        'val[title]': request.title,
        'val[location]': request.location,
        'val[lat]': request.lat,
        'val[lng]': request.lng,
        'val[attachment]': request.attachment,
        'val[tags]': request.tags,
        'val[line_up][artist]': request.artist,
        'val[line_up][entertainment]': request.entertainment,
        'val[start_day]': request.startDate,
        'val[start_month]': request.starMonth,
        'val[start_year]': request.startYear,
        'val[start_hour]': request.startHour,
        'val[start_minute]': request.startMinute,
        'val[end_day]': request.endDate,
        'val[end_month]': request.endMonth,
        'val[end_year]': request.endYear,
        'val[end_hour]': request.endHour,
        'val[end_minute]': request.endMinute,
        'image': imageFile,
        'val[host_name]': request.hostName,
        'val[host_description]': request.hostDescription,
        'val[website]': request.hostWebsite,
        'val[facebook]': request.hostFacebook,
        'val[twitter]': request.hostTwitter,
        'val[privacy]': request.privacy,
        'val[privacy_comment]': request.privacyComment,
      }),
    );
    return response.mapData(
      (json) => EventResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<CommentResponse> editComment(
    String text,
    int id,
  ) async {
    final response = await _dioHelper.put(
      route: '/restful_api/comment/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'text': text,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    return response.mapData(
      (json) => CommentResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<CommentResponse>> deleteComment(
    int id,
  ) async {
    final response = await _dioHelper.delete(
      route: '/restful_api/comment/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<Song>> getSongRecommended(
    int id,
  ) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/$id/recommended-songs',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<Album>> getAlbumRecommended(
    int id,
  ) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/album/$id/recommended-album',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<PlaylistResponse>> getPlayListRecommended(
    int id,
  ) async {
    final response = await _dioHelper.get(
      route: '/restful_api/playlist/$id/recommended-playlists',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => PlaylistResponse.fromJson(e as Map<String, dynamic>)).toList(),
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

  Future<List<ProfileData>> getListUsers(String query, String? groupUserId) async {
    var endpoint = '';
    if (groupUserId == null) {
      endpoint = '/restful_api/user?page=1&limit=20';
    } else {
      endpoint = '/restful_api/user?page=1&limit=20&user_group_id=$groupUserId';
    }
    final response = await _dioHelper.get(
      route: endpoint,
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => ProfileData.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<RegisterResponse> uploadSong(UploadRequest result) async {
    final dataRequest = await result.toJson();
    final response = await _dioHelper.post(
      route: '/restful_api/song',
      requestBody: FormData.fromMap(dataRequest),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    if (response.status == StatusString.success) {
      return RegisterResponse(
        // ignore: cast_nullable_to_non_nullable
        status: response.status as String,
        message: response.message as String?,
      );
    } else {
      return RegisterResponse(status: response.status as String, message: response.error['message'] as String);
    }
  }

  Future<CreateAlbumResponse> uploadAlbum(UploadRequest result) async {
    final dataRequest = await result.toJson();
    final response = await _dioHelper.post(
      route: '/restful_api/song/album',
      requestBody: FormData.fromMap(dataRequest),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    if (response.status == StatusString.success) {
      return CreateAlbumResponse(
        // ignore: cast_nullable_to_non_nullable
        status: response.status as String,
        message: response.message as String?,
        data: response.data['album_id'] as String?,
      );
    } else {
      return CreateAlbumResponse(status: response.status as String, message: response.error['message'] as String);
    }
  }

  Future<CreateAlbumResponse> deleteSongId(String? songId) async {
    final response = await _dioHelper.delete(
      route: '/restful_api/music/$songId',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    if (response.isSuccess!) {
      return CreateAlbumResponse(
        // ignore: cast_nullable_to_non_nullable
        status: response.status as String,
        message: response.message as String?,
        data: response.data['message'] as String?,
      );
    } else {
      return CreateAlbumResponse(status: response.status as String, message: response.error['message'] as String);
    }
  }

  Future<CreateAlbumResponse> deletedAlbumId(String? albumId) async {
    final response = await _dioHelper.delete(
      route: '/restful_api/song/album/$albumId',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    if (response.isSuccess!) {
      return CreateAlbumResponse(
        // ignore: cast_nullable_to_non_nullable
        status: response.status as String,
        message: response.message as String?,
        data: response.message as String?,
      );
    } else {
      return CreateAlbumResponse(status: response.status as String, message: response.error['message'] as String);
    }
  }

  Future<List<AtlasCategory>> getAtlasCategories() async {
    if (_atlasCategories?.isNotEmpty == true) {
      return _atlasCategories!;
    }
    _atlasCategories = await _dioHelper.get(
      route: '/restful_api/atlas/category',
      responseBodyMapper: (jsonMapper) {
        final categoryData = jsonMapper['data'];
        final allKeys = categoryData.keys as Iterable<String>;
        return allKeys.map((key) {
          final json = categoryData[key] as Map<String, dynamic>;
          return AtlasCategory.fromJson(json);
        }).toList();
      },
    );
    return _atlasCategories!;
  }

  Future<List<AtlasUser>> getAtlasUsers(FilterUsersRequest params) async {
    final response = await _dioHelper.get(
      route: '/restful_api/atlas',
      requestParams: params.toJson(),
      responseBodyMapper: (jsonMapper) => AtlasUserResponse.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return Future.value(response.data);
  }

  Future<UserSubscriptionResponse> subscribeUser(AtlasUser user) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user/${user.userId!}/subscribe',
      requestParams: {
        'val[is_subscribed]':
            user.isSubscribed == true ? SubscriptionStatus.unsubscribe.value : SubscriptionStatus.subscribe.value
      },
      responseBodyMapper: (json) => UserSubscriptionResponse.fromJson(json as Map<String, dynamic>),
    );
    return response;
  }

  Future<CreateAlbumResponse> editAlbum(UploadRequest result) async {
    final dataRequest = await result.toJson();
    final response = await _dioHelper.put(
      route: '/restful_api/song/album/${result.albumId}',
      requestBody: dataRequest,
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    if (response.status == StatusString.success) {
      return CreateAlbumResponse(
        // ignore: cast_nullable_to_non_nullable
        status: response.status as String,
        message: response.message as String?,
      );
    } else {
      return CreateAlbumResponse(status: response.status as String, message: response.error['message'] as String);
    }
  }

  Future<CreateAlbumResponse> editSong(UploadRequest result) async {
    final dataRequest = await result.toJson();
    final response = await _dioHelper.put(
      route: '/restful_api/music/${result.songId}',
      requestBody: dataRequest,
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    if (response.status == StatusString.success) {
      return CreateAlbumResponse(
        // ignore: cast_nullable_to_non_nullable
        status: response.status as String,
        message: response.message as String?,
      );
    } else {
      return CreateAlbumResponse(status: response.status as String, message: response.error['message'] as String);
    }
  }

  Future<List<Country>> getAllCountries() async {
    if (_countries?.isNotEmpty == true) {
      return _countries!;
    }
    _countries = await _dioHelper.get(
      route: '/restful_api/event/country',
      responseBodyMapper: (json) {
        final countriesData = json['data'];
        final allKeys = countriesData.keys as Iterable<String>;
        return allKeys.map((key) {
          final json = countriesData[key] as Map<String, dynamic>;
          return Country.fromJson(json);
        }).toList();
      },
    );

    return _countries ?? [];
  }

  Future<List<EventResponse>> getMyDiaryEvents(MyDiaryEventRequest request) async {
    final response = await _dioHelper.get(
        route: '/restful_api/advancedevent/my_diary',
        requestParams: request.toJson(),
        responseBodyMapper: (json) => BaseRes.fromJson(json as Map<String, dynamic>));
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => EventResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
