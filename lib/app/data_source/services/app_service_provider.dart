import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/account_settings.dart';
import 'package:audio_cult/app/data_source/models/notification_option.dart';
import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/app/data_source/models/requests/create_post_request.dart';
import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/feed_request.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/requests/get_invitation_request.dart';
import 'package:audio_cult/app/data_source/models/requests/invite_friend_request.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/notification_request.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:audio_cult/app/data_source/models/requests/remove_song_request.dart';
import 'package:audio_cult/app/data_source/models/requests/report_request.dart';
import 'package:audio_cult/app/data_source/models/requests/top_song_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_photo_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_video_request.dart';
import 'package:audio_cult/app/data_source/models/requests/video_request.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/announcement/announcement_response.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_category.dart';
import 'package:audio_cult/app/data_source/models/responses/cart_response.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/data_source/models/responses/create_playlist/create_playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/create_post/create_post_response.dart';
import 'package:audio_cult/app/data_source/models/responses/event_invitation/event_invitation_response.dart';
import 'package:audio_cult/app/data_source/models/responses/event_invitation/invite_friend_response.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/data_source/models/responses/language_response.dart';
import 'package:audio_cult/app/data_source/models/responses/localized_text.dart';
import 'package:audio_cult/app/data_source/models/responses/login_response.dart';
import 'package:audio_cult/app/data_source/models/responses/notifications/notification_response.dart';
import 'package:audio_cult/app/data_source/models/responses/page_template_custom_field_response.dart';
import 'package:audio_cult/app/data_source/models/responses/page_template_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/update_playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/privacy_settings/privacy_settings_response.dart';
import 'package:audio_cult/app/data_source/models/responses/reasons/reason_response.dart';
import 'package:audio_cult/app/data_source/models/responses/timezone/timezone_response.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_response.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_photo/upload_photo_response.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_video/upload_video_response.dart';
import 'package:audio_cult/app/data_source/models/responses/user_subscription_response.dart';
import 'package:audio_cult/app/data_source/models/responses/video_data.dart';
import 'package:audio_cult/app/data_source/models/update_account_settings_response.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/extensions/app_extensions.dart';
import '../models/base_response.dart';
import '../models/requests/login_request.dart';
import '../models/requests/remove_account_request.dart';
import '../models/responses/atlas_user.dart';
import '../models/responses/background/background_response.dart';
import '../models/responses/create_album_response.dart';
import '../models/responses/events/event_category_response.dart';
import '../models/responses/playlist/delete_playlist_response.dart';
import '../models/responses/post_reaction/post_reaction.dart';
import '../models/responses/profile_data.dart';
import '../models/responses/register_response.dart';
import '../models/responses/song/song_response.dart';
import '../models/responses/terms/terms_response.dart';
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
      // options: Options(headers: {'Authorization': AppConstants.basicToken}),
      requestBody: FormData.fromMap({
        'grant_type': 'client_credentials',
        'client_id': AppConstants.clientId,
        'client_secret': AppConstants.clientSecret
      }),
      route: '/restful_api/token',
    );
    return LoginResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<BaseRes> removeSongFromPlaylist(RemoveSongRequest request) async {
    final params = await request.toJson();

    final response = await _dioHelper.post(
        route: '/restful_api/playlist/remove-songs',
        responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
        requestBody: FormData.fromMap(params));

    return response.mapData((json) => BaseRes.fromJson(json as Map<String, dynamic>));
  }

  Future<BaseRes> removeAccount(RemoveAccountRequest request) async {
    final params = await request.toJson();

    final response = await _dioHelper.post(
      route: '/restful_api/user/delete-account',
      requestBody: FormData.fromMap(params),
    );

    return BaseRes.fromJson(response as Map<String, dynamic>);
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

  Future<List<AnnouncementResponse>> getAnnouncements(int page, int limit) async {
    final response = await _dioHelper.get(
      route: '/restful_api/announcement',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'page': page,
        'limit': limit,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) =>
          asType<List<dynamic>>(json)?.map((e) => AnnouncementResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<FeedResponse>> getFeeds(FeedRequest request) async {
    final data = await request.toJson();
    final response = await _dioHelper.get(
      route: '/restful_api/feed',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: data,
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => FeedResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<EventInvitationResponse>> getInvitation(GetInvitationRequest request) async {
    final data = await request.toJson();
    final response = await _dioHelper.get(
      route: '/restful_api/invite',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: data,
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json['items'])
          ?.map((e) => EventInvitationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<InviteFriendResponse> inviteFriends(InviteFriendRequest request) async {
    final params = await request.toJson();
    final response = await _dioHelper.post(
      route: '/restful_api/invite',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap(params),
    );
    return response.mapData(
      (json) => InviteFriendResponse.fromJson(json as Map<String, dynamic>),
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

  Future<List<DeletePlayListResponse>> deleteFeed(int id) async {
    final response = await _dioHelper.delete(
      route: '/restful_api/feed/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) =>
          asType<List<dynamic>>(json)?.map((e) => DeletePlayListResponse.fromJson(e as Map<String, dynamic>)).toList(),
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

  Future<List<BackgroundResponse>> getBackgrounds() async {
    final response = await _dioHelper.get(
      route: '/restful_api/user/status/background',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) =>
          asType<List<dynamic>>(json)?.map((e) => BackgroundResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<UpdatePlaylistResponse> updatePlaylist(CreatePlayListRequest request) async {
    final params = await request.toJson();
    final response = await _dioHelper.put(
      route: '/restful_api/playlist/${request.id}',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: params,
    );
    if (response.status == StatusString.success) {
      return UpdatePlaylistResponse(
        // ignore: cast_nullable_to_non_nullable
        status: response.status as String,
        message: response.message as String?,
      );
    } else {
      return UpdatePlaylistResponse(
        status: response.status as String,
        message: response.error['message'] as String,
      );
    }
  }

  Future<CreatePostResponse> createPost(CreatePostRequest request) async {
    final params = await request.toJson();
    final response = await _dioHelper.post(
      route: '/restful_api/user/status',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap(params),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => CreatePostResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<CreatePostResponse> createPostEvent(CreatePostRequest request) async {
    final params = await request.toJson();
    final response = await _dioHelper.post(
      route: '/restful_api/event/feed-comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap(params),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => CreatePostResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<UploadVideoResponse> uploadVideo(UploadVideoRequest request) async {
    var video;

    if (request.video != null) {
      video = await MultipartFile.fromFile(request.video?.path ?? '');
    }

    final response = await _dioHelper.post(
      route: '/restful_api/video',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap({
        'ajax_upload': video,
        'val[title]': request.title,
        'val[tagged_friends]': request.taggedFriends,
        'val[location][latlng]': request.latLng,
        'val[location][name]': request.locationName,
        'val[url]': request.url,
        'val[status_info]': request.statusInfo,
        'val[privacy]': request.privacy,
        'val[parent_user_id]': request.userId,
      }),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => UploadVideoResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<UploadPhotoResponse>> uploadPhoto(UploadPhotoRequest request) async {
    final listImages = <MultipartFile>[];

    for (final image in request.images!) {
      listImages.add(await MultipartFile.fromFile(image.path));
    }

    final response = await _dioHelper.post(
      route: '/restful_api/photo',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap({
        'image[]': listImages,
        'val[tagged_friends]': request.taggedFriends,
        'val[description]': request.description,
        'val[location][latlng]': request.latLng,
        'val[location][name]': request.locationName,
        'val[user_id]': request.userId,
        'val[album_id]': request.albumId,
        'val[privacy]': request.privacy,
        'val[parent_user_id]': request.userId,
      }),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) =>
          asType<List<dynamic>>(json)?.map((e) => UploadPhotoResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<TermsResponse> getTerms(String titleUrl) async {
    final response = await _dioHelper.get(
      route: '/restful_api/page',
      requestParams: {'title_url': titleUrl},
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => TermsResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<EventResponse>> getEvents(EventRequest request, {bool? hasTicket}) async {
    final response = await _dioHelper.get(
      route: '/restful_api/event',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestParams: {
        'category_id': request.categoryId,
        'search[search]': request.query,
        'postal_code': request.postalCode,
        'location': request.location,
        'country_iso': request.countryIso,
        'view': request.view,
        'tag': request.tag,
        'distance': request.distance,
        'when': request.when,
        'start_time': request.startTime,
        'end_time': request.endTime,
        'sort': request.sort,
        'page': request.page,
        'limit': request.limit,
        'user_id': request.userId,
        'is_buyed': hasTicket
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

  Future<List<dynamic>> getAlbums(
      String query, String view, String sort, String genresId, String when, int page, int limit,
      {String? userId}) async {
    final response = await _dioHelper.get(
      route: '/restful_api/song/album',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'search[search]': query,
        'view': view,
        'sort': sort,
        'genres_id': genresId,
        'when': when,
        'page': page,
        'limit': limit,
        'user_id': userId,
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

  Future<List<PlaylistResponse>> getPlaylists(
      String query, int page, int limit, String sort, String genresId, String when, int getAll) async {
    final response = await _dioHelper.get(
      route: '/restful_api/playlist',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'search[search]': query,
        'page': page,
        'limit': limit,
        'sort': sort,
        'genres_id': genresId,
        'when': when,
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
    String genresId,
    String when,
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
        'genres_id': genresId,
        'when': when,
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

  Future<List<Song>> getTopSongs(TopSongRequest request) async {
    final params = await request.toJson();
    final response = await _dioHelper.get(
      route: '/restful_api/song',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: params,
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<CommentResponse>> blockUser(int userId) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user/block-user',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: {
        'user_id': userId,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>)).toList(),
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

  Future<Song> getSongDetail(int id) async {
    final response = await _dioHelper.get(
      route: '/restful_api/music/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => Song.fromJson(json as Map<String, dynamic>),
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

  Future<List<ReasonResponse>> getReasons() async {
    final response = await _dioHelper.get(
      route: '/restful_api/report/reasons',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => ReasonResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<CommentResponse>> report(ReportRequest request) async {
    final data = await request.toJson();
    final response = await _dioHelper.post(
      route: '/restful_api/report',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap(data),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<CommentResponse>> getComments(int id, String typeId, int page, int limit, String sort) async {
    final response = await _dioHelper.get(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'item_id': id,
        'type_id': typeId,
        'page': page,
        'limit': limit,
        'sort': sort,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<CommentResponse> createComment(int itemId, String type, String text, {int? feedId}) async {
    final response = await _dioHelper.post(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap({
        'val[item_id]': itemId,
        'val[type]': type,
        'val[text]': text,
        'val[feed_id]': feedId,
      }),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => CommentResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<List<CommentResponse>> getReplies(
    int parentId,
    int itemId,
    String typeId,
    int page,
    int limit,
    String sort,
  ) async {
    final response = await _dioHelper.get(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestParams: {
        'parent_id': parentId,
        'item_id': itemId,
        'type_id': typeId,
        'page': page,
        'limit': limit,
        'sort': sort,
      },
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<dynamic>> getReactionIcons() async {
    final response = await _dioHelper.get(
      route: '/restful_api/like/icon',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json),
    );
  }

  Future<PostReactionResponse> postReactionIcon(String typeId, int itemId, int likeType, {String? feedEventId}) async {
    final response = await _dioHelper.post(
      route: '/restful_api/like/item',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap({
        'feed_id': feedEventId,
        'type_id': typeId,
        'item_id': itemId,
        'like_type': likeType,
      }),
    );
    return response.mapData(
      (json) => PostReactionResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<CreatePlayListResponse> createPlayList(CreatePlayListRequest request) async {
    var imageFile;

    if (request.file != null) {
      imageFile = await MultipartFile.fromFile(request.file?.path ?? '');
    }

    final response = await _dioHelper.post(
      route: '/restful_api/playlist',
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap({
        'val[title]': request.title,
        'image': imageFile,
        'val[description]': request.description,
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
    final params = await request.toJson();
    final response = await _dioHelper.post(
      route: '/restful_api/event',
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
      requestBody: FormData.fromMap(params),
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

  Future<DeletePlayListResponse> deletePlayList(
    int id,
  ) async {
    final response = await _dioHelper.delete(
      route: '/restful_api/playlist/$id',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => DeletePlayListResponse.fromJson(json as Map<String, dynamic>),
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

  Future<CommentResponse> createReply(int parentId, int itemId, String type, String text, {int? feedId}) async {
    final response = await _dioHelper.post(
      route: '/restful_api/comment',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      requestBody: FormData.fromMap({
        'val[parent_id]': parentId,
        'val[item_id]': itemId,
        'val[type]': type,
        'val[text]': text,
        'val[feed_id]': feedId,
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

  Future<List<NotificationResponse>> getNotifications(NotificationRequest request) async {
    final response = await _dioHelper.get(
      route: '/restful_api/notification',
      requestParams: {
        'page': request.page,
        'limit': request.limit,
        'group_by_date': request.groupByDate,
      },
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) =>
          asType<List<dynamic>>(json)?.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<NotificationResponse>> markAllRead() async {
    final response = await _dioHelper.post(
      route: '/restful_api/notification/mark-all-read',
      options: Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.mapData(
      (json) =>
          asType<List<dynamic>>(json)?.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>)).toList(),
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
        {
          'client_id': AppConstants.clientId,
          'client_secret': AppConstants.clientSecret,
          'token': pref.accessToken,
          'fcm_token': pref.fcmToken
        },
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

  Future<dynamic> getUserProfile(String? userId, {String? data = 'info'}) async {
    final response = await _dioHelper.get(
      route: '/restful_api/user/$userId?data=$data',
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

  Future<List<AtlasUser>> getAtlasUsers(FilterUsersRequest params, {CancelToken? cancel}) async {
    final response = await _dioHelper.get(
      route: '/restful_api/atlas',
      requestParams: params.toJson(),
      cancelToken: cancel,
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
    final response = await _dioHelper.post(
      route: '/restful_api/song/album/${result.albumId}',
      options: Options(headers: {
        'Content-Type': 'multipart/form-data; charset=UTF-8;',
        'Accept-Encoding': '*',
        'Accept-Language': 'en-US,en;q=0.9'
      }),
      requestBody: FormData.fromMap(dataRequest),
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

  Future<List<EventResponse>> getMyDiaryEvents(MyDiaryEventRequest request, {CancelToken? cancel}) async {
    final response = await _dioHelper.get(
        route: '/restful_api/advancedevent/my_diary',
        requestParams: request.toJson(),
        cancelToken: cancel,
        responseBodyMapper: (json) => BaseRes.fromJson(json as Map<String, dynamic>));
    return response.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => EventResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<List<ProfileData>> getListSubscriptions(String? userId, int page, int limit) async {
    final response = await _dioHelper.get(
        route: '/restful_api/user/$userId/subscriptions?page=$page&limit=$limit',
        responseBodyMapper: (json) => BaseRes.fromJson(json as Map<String, dynamic>));

    return response.mapData((json) {
      if (json == null) {
        return <ProfileData>[];
      } else {
        return asType<List<dynamic>>(json['subscriptions'])
            ?.map((e) => ProfileData.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    });
  }

  Future<String> uploadAvatar(XFile file) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user/profile-image',
      requestBody: FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: file.name,
          contentType: MediaType('image', 'jpeg'),
        )
      }),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.data['user_image'] as String;
  }

  Future<PageTemplateResponse> getPageTemplateData({String? userGroupId}) async {
    List<SelectableOption>? getSelectableOptions(dynamic json) {
      if (json != null && json.keys != null) {
        final keys = json.keys as Iterable<String>;
        if (keys.isNotEmpty) {
          return keys.map((e) {
            final option = SelectableOption.fromJson(json[e] as Map<String, dynamic>);
            option.key = e;
            return option;
          }).toList();
        }
        return null;
      }
      return null;
    }

    List<PageTemplateCustomFieldConfig>? getCustomFields(dynamic json) {
      if (json != null && json.keys != null) {
        final keys = json.keys as Iterable<String>;
        if (keys.isNotEmpty) {
          return keys.map((e) {
            final customField = PageTemplateCustomFieldConfig.fromJson(json[e] as Map<String, dynamic>);
            customField.options = getSelectableOptions(json[e]['options']);
            return customField;
          }).toList();
        }
        return null;
      }
      return null;
    }

    final userProfile = await _dioHelper.get(
      route: '/restful_api/user/profile',
      requestParams: {'user_group_id': userGroupId},
      responseBodyMapper: (json) {
        final dataJson = json['data'] as Map<String, dynamic>;
        final userProfile = PageTemplateResponse.fromJson(dataJson);
        final customFieldsJson = json['data']['custom_fields'];
        userProfile.customFields = getCustomFields(customFieldsJson);
        return userProfile;
      },
    );
    return userProfile;
  }

  Future<bool> updatePageTemplate(Map<String, dynamic> params) async {
    final result = await _dioHelper.post(
      route: '/restful_api/user/profile',
      requestBody: FormData.fromMap(params),
      responseBodyMapper: (jsonMapper) {
        return jsonMapper['status'] == StatusString.success;
      },
    );
    return result;
  }

  Future<UpdateAccountSettingsResponse> updateAccountSettings(AccountSettings accountSettings) async {
    final result = await _dioHelper.post(
      route: '/restful_api/user/settings',
      requestBody: FormData.fromMap(accountSettings.toJson()),
      responseBodyMapper: (jsonMapper) {
        return UpdateAccountSettingsResponse.fromJson(jsonMapper as Map<String, dynamic>);
      },
    );
    return result;
  }

  Future<List<NotificationOption>> getAllNotificationOptions() async {
    final result = await _dioHelper.get(
        route: '/restful_api/user/notification-settings',
        responseBodyMapper: (json) {
          final dataJson = json['data'] as Map<String, dynamic>;
          final keys = dataJson.keys;
          final notifications = keys.map((key) {
            return NotificationOption.fromJson(key, dataJson[key] as Map<String, dynamic>);
          }).toList();
          return notifications;
        });
    return result;
  }

  Future<bool> updateNotificationData(List<NotificationOption> notifications) async {
    final params = <String, dynamic>{};
    for (final noti in notifications) {
      params['val[${noti.key}]'] = noti.isChecked == true ? 1 : 0;
    }
    final result = await _dioHelper.post(
      route: '/restful_api/user/notification-settings',
      requestBody: FormData.fromMap(params),
      responseBodyMapper: (json) {},
    );
    return false;
  }

  Future<List<Video>> getVideos(VideoRequest? params) async {
    final result = await _dioHelper.get(
      requestParams: params?.toJson(),
      route: '/restful_api/user/profile/video',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );

    return result.mapData(
      (json) => asType<List<dynamic>>(json)?.map((e) => Video.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Future<TimeZoneReponse> getAllTimezones() async {
    final result = await _dioHelper.get(
      route: '/restful_api/user/timezones',
      responseBodyMapper: (json) => TimeZoneReponse.fromJson(json as Map<String, dynamic>),
    );
    return result;
  }

  Future<List<Language>> getSupportedLanguages() async {
    try {
      final result = await _dioHelper.get(
        route: '/restful_api/language',
        responseBodyMapper: (json) {
          final data = json['data'] as List<dynamic>;
          return data.map((e) => Language.fromJson(e as Map<String, dynamic>)).toList();
        },
      );
      return result;
    } catch (_) {
      return [];
    }
  }

  Future<ProfileData> getMyUserInfo() async {
    final result = await _dioHelper.get(
      route: '/restful_api/user/mine',
      responseBodyMapper: (json) => ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );
    return result;
  }

  Future<PrivacySettingsReponse> getPrivacySettings() async {
    final result = await _dioHelper.get(
      route: '/restful_api/user/privacy',
      responseBodyMapper: (json) => PrivacySettingsReponse.fromJson(json as Map<String, dynamic>),
    );
    return result;
  }

  Future<PrivacySettingsReponse> updatePrivacySetting(List<PrivacySettingItem> items) async {
    final params = <String, dynamic>{};
    for (final item in items) {
      params['val[${item.prefix}][${item.name}]'] = item.defaultValue;
    }
    final result = await _dioHelper.post(
      route: '/restful_api/user/privacy',
      requestBody: FormData.fromMap(params),
      responseBodyMapper: (json) => PrivacySettingsReponse.fromJson(json as Map<String, dynamic>),
    );
    return result;
  }

  Future<Exception?> unblockUser(String userId) async {
    final result = await _dioHelper.delete(
      route: '/restful_api/user/block-user',
      requestParams: {'user_id': userId},
      responseBodyMapper: (json) {
        final error = json['error'];
        if (error != null) {
          return Exception(error['message']);
        }
        return null;
      },
    );
    return result;
  }

  Future<BaseRes?> resentEmail(String email, String token) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user/forgot-password',
      requestBody: FormData.fromMap({'val[email]': email}),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }

  Future<BaseRes?> resetPassword(String newPassword, String hashId, String token) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user/reset-password',
      requestBody: FormData.fromMap({'val[newpassword]': newPassword, 'val[code]': hashId}),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }

  Future<UniversalSearchReponse> getUniversalSearch({
    required String keyword,
    required int page,
    required UniversalSearchView searchView,
    int limit = 20,
    CancelToken? cancel,
  }) async {
    final params = <String, dynamic>{};
    params['keyword'] = keyword;
    params['page'] = page;
    params['limit'] = limit;
    if (searchView != UniversalSearchView.all) {
      params['view'] = searchView.value;
    }
    final response = await _dioHelper.get(
      cancelToken: cancel,
      route: '/restful_api/search',
      requestParams: params,
      responseBodyMapper: (jsonMapper) {
        return UniversalSearchReponse.fromJson(jsonMapper as Map<String, dynamic>);
      },
    );
    return response;
  }

  Future<CartResponse> getAllCartItems() async {
    final response = await _dioHelper.get(
        route: '/restful_api/cart',
        responseBodyMapper: (jsonMapper) {
          return CartResponse.fromJson(jsonMapper['data'] as Map<String, dynamic>);
        });
    return response;
  }

  Future<bool> deleteCartItems(List<String> itemIds) async {
    final params = <String, dynamic>{};
    params['val[song_ids]'] = itemIds.join(',');
    final result = await _dioHelper.delete(
        route: '/restful_api/cart',
        requestBody: params,
        responseBodyMapper: (jsonMapper) {
          return jsonMapper['status'].toString().toLowerCase() == RequestStatus.success.value;
        });
    return result;
  }

  Future<bool> addCartItem(String id) async {
    final params = <String, dynamic>{};
    params['val[item_id]'] = id;
    final result = await _dioHelper.post(
      route: '/restful_api/cart',
      requestParams: params,
      responseBodyMapper: (jsonMapper) {
        return jsonMapper['status'].toString().toLowerCase() == RequestStatus.success.value;
      },
    );
    return result;
  }

  Future<BaseRes?> sendCode(String code, String token) async {
    final response = await _dioHelper.post(
      route: '/restful_api/user/verify-reset-password',
      requestBody: FormData.fromMap({'val[code]': code}),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }

  Future<String?> getCount() async {
    final token = await authentication();
    final response = await _dioHelper.get(
      route: '/restful_api/user/statistics',
      options: Options(headers: {'Authorization': 'Bearer ${token.accessToken}'}),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response.data['total_user'].toString();
  }

  Future<Map<String, dynamic>?> getLocalizedTextData(String languageId) async {
    final result = await _dioHelper.get(
      route: '/restful_api/language/phrases',
      requestParams: {'language_id': languageId},
      responseBodyMapper: (json) {
        final response = BaseRes<List<dynamic>>.fromJson(json as Map<String, dynamic>);
        if (response.isSuccess == true) {
          final listOfTranslatedText = response.data
                  ?.map(
                    (e) => TranslatedText.fromJson(e as Map<String, dynamic>).toDictionary(),
                  )
                  .toList() ??
              [];
          final dictionary = <String, dynamic>{};
          for (final text in listOfTranslatedText) {
            dictionary.addAll(text);
          }
          return dictionary;
        }
        return null;
      },
    );
    return result;
  }

  Future<BaseRes> getAllMyTickets({String? eventId}) async {
    final response = await _dioHelper.get(
      route: '/restful_api/event/ticket',
      requestParams: {'event_id': eventId},
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }
}
