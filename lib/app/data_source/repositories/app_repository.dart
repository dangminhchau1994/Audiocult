import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/account_settings.dart';
import 'package:audio_cult/app/data_source/models/cache_filter.dart';
import 'package:audio_cult/app/data_source/models/notification_option.dart';
import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/app/data_source/models/requests/create_post_request.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/requests/notification_request.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
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
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/models/responses/language_response.dart';
import 'package:audio_cult/app/data_source/models/responses/notifications/notification_response.dart';
import 'package:audio_cult/app/data_source/models/responses/page_template_response.dart';
import 'package:audio_cult/app/data_source/models/responses/place.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/delete_playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/update_playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/post_reaction/post_reaction.dart';
import 'package:audio_cult/app/data_source/models/responses/privacy_settings/privacy_settings_response.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import 'package:audio_cult/app/data_source/models/responses/timezone/timezone_response.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_response.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_photo/upload_photo_response.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_video/upload_video_response.dart';
import 'package:audio_cult/app/data_source/models/responses/user_subscription_response.dart';
import 'package:audio_cult/app/data_source/models/responses/video_data.dart';
import 'package:audio_cult/app/data_source/models/update_account_settings_response.dart';
import 'package:audio_cult/app/data_source/networks/exceptions/no_cache_exception.dart';
import 'package:audio_cult/app/data_source/services/hive_service_provider.dart';
import 'package:audio_cult/app/features/auth/widgets/register_page.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../models/base_response.dart';
import '../models/requests/event_request.dart';
import '../models/requests/login_request.dart';
import '../models/responses/atlas_user.dart';
import '../models/responses/background/background_response.dart';
import '../models/responses/create_album_response.dart';
import '../models/responses/events/event_category_response.dart';
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
  final PrefProvider prefProvider;

  AppRepository({
    required this.appServiceProvider,
    required this.placeServiceProvider,
    required this.hiveServiceProvider,
    required this.assetsLocalServiceProvider,
    required this.prefProvider,
  });

  Future<Either<LoginResponse, Exception>> login(LoginRequest request) {
    return safeCall(() => appServiceProvider.login(request));
  }

  Future<Either<List<Song>, Exception>> getTopSongs(
    String query,
    String sort,
    String genresId,
    String when,
    int page,
    int limit,
  ) {
    return safeCall(
      () => appServiceProvider.getTopSongs(query, sort, genresId, when, page, limit),
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

  Future<Either<List<AnnouncementResponse>, Exception>> getAnnouncements(
    int page,
    int limit,
  ) {
    return safeCall(
      () => appServiceProvider.getAnnouncements(page, limit),
    );
  }

  Future<Either<List<FeedResponse>, Exception>> getFeeds(int page, int limit, int lastFeedId) {
    return safeCall(
      () => appServiceProvider.getFeeds(page, limit, lastFeedId),
    );
  }

  Future<Either<List<NotificationResponse>, Exception>> getNotifications(NotificationRequest request) {
    return safeCall(
      () => appServiceProvider.getNotifications(request),
    );
  }

  Future<Either<List<Album>, Exception>> getAlbums(
    String query,
    String view,
    String sort,
    String genresId,
    String when,
    int page,
    int limit, {
    String? userId,
  }) async {
    final albums = await safeCall(
      () async {
        final result =
            await appServiceProvider.getAlbums(query, view, sort, genresId, when, page, limit, userId: userId);
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

  Future<Either<List<DeletePlayListResponse>, Exception>> deleteFeed(int id) {
    return safeCall(
      () => appServiceProvider.deleteFeed(id),
    );
  }

  Future<Either<EventResponse, Exception>> getEventDetail(int id) {
    return safeCall(
      () => appServiceProvider.getEventDetail(id),
    );
  }

  Future<Either<List<EventResponse>, Exception>> updateEventStatus(int id, int rsvp) {
    return safeCall(
      () => appServiceProvider.updateEventStatus(id, rsvp),
    );
  }

  Future<Either<CommentResponse, Exception>> editComment(
    String text,
    int id,
  ) {
    return safeCall(
      () => appServiceProvider.editComment(text, id),
    );
  }

  Future<Either<List<CommentResponse>, Exception>> deleteComment(
    int id,
  ) {
    return safeCall(
      () => appServiceProvider.deleteComment(id),
    );
  }

  Future<Either<List<EventResponse>, Exception>> getEvents(
    EventRequest request,
  ) {
    return safeCall(
      () => appServiceProvider.getEvents(request),
    );
  }

  Future<Either<List<BackgroundResponse>, Exception>> getBackgrounds() {
    return safeCall(
      appServiceProvider.getBackgrounds,
    );
  }

  Future<Either<DeletePlayListResponse, Exception>> deletePlayList(int id) {
    return safeCall(
      () => appServiceProvider.deletePlayList(id),
    );
  }

  Future<Either<Song, Exception>> getSongDetail(int id) {
    return safeCall(
      () => appServiceProvider.getSongDetail(id),
    );
  }

  Future<Either<CreatePostResponse, Exception>> createPost(CreatePostRequest request) {
    return safeCall(
      () => appServiceProvider.createPost(request),
    );
  }

  Future<Either<List<UploadPhotoResponse>, Exception>> uploadPhoto(UploadPhotoRequest request) {
    return safeCall(() => appServiceProvider.uploadPhoto(request));
  }

  Future<Either<UploadVideoResponse, Exception>> uploadVideo(UploadVideoRequest request) {
    return safeCall(() => appServiceProvider.uploadVideo(request));
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

  Future<Either<List<CommentResponse>, Exception>> getComments(
      int id, String typeId, int page, int limit, String sort) {
    return safeCall(
      () => appServiceProvider.getComments(
        id,
        typeId,
        page,
        limit,
        sort,
      ),
    );
  }

  Future<Either<List<Song>, Exception>> getSongRecommended(int id) {
    return safeCall(
      () => appServiceProvider.getSongRecommended(id),
    );
  }

  Future<Either<List<Album>, Exception>> getAlbumRecommended(int id) {
    return safeCall(
      () => appServiceProvider.getAlbumRecommended(id),
    );
  }

  Future<Either<List<PlaylistResponse>, Exception>> getPlayListRecommended(int id) {
    return safeCall(
      () => appServiceProvider.getPlayListRecommended(id),
    );
  }

  Future<Either<CommentResponse, Exception>> createComment(int itemId, String type, String text, {int? feedId}) {
    return safeCall(
      () => appServiceProvider.createComment(itemId, type, text, feedId: feedId),
    );
  }

  Future<Either<List<ReactionIconResponse>, Exception>> getReactionIcons() async {
    final result = await safeCall(appServiceProvider.getReactionIcons);

    return result.fold((l) {
      hiveServiceProvider.saveReactions(l);
      return left(l.map((e) => ReactionIconResponse.fromJson(e as Map<String, dynamic>)).toList());
    }, (r) {
      final localReaction = hiveServiceProvider.getReactions();

      if (localReaction.isEmpty) {
        return right(NoCacheDataException(''));
      } else {
        return left(localReaction);
      }
    });
  }

  Future<Either<PostReactionResponse, Exception>> postReactionIcon(String typeId, int itemId, int likeType) {
    return safeCall(
      () => appServiceProvider.postReactionIcon(typeId, itemId, likeType),
    );
  }

  Future<Either<List<NotificationResponse>, Exception>> markAllRead() {
    return safeCall(appServiceProvider.markAllRead);
  }

  Future<Either<List<CommentResponse>, Exception>> getReplies(
    int parentId,
    int id,
    String typeId,
    int page,
    int limit,
    String sort,
  ) {
    return safeCall(
      () => appServiceProvider.getReplies(parentId, id, typeId, page, limit, sort),
    );
  }

  Future<Either<CommentResponse, Exception>> createReply(int parentId, int itemId, String type, String text,
      {int? feedId}) {
    return safeCall(
      () => appServiceProvider.createReply(parentId, itemId, type, text, feedId: feedId),
    );
  }

  Future<Either<List<EventCategoryResponse>, Exception>> getEventCategories() {
    return safeCall(
      appServiceProvider.getEventCategories,
    );
  }

  Future<Either<List<Song>, Exception>> getMixTapSongs(
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
  }) {
    return safeCall(
      () => appServiceProvider.getMixTapSongs(query, sort, genresId, when, page, limit, view, type,
          userId: userId, albumId: albumId),
    );
  }

  Future<Either<CreatePlayListResponse, Exception>> createPlayList(
    CreatePlayListRequest request,
  ) {
    return safeCall(
      () => appServiceProvider.createPlayList(request),
    );
  }

  Future<Either<UpdatePlaylistResponse, Exception>> updatePlaylist(
    CreatePlayListRequest request,
  ) {
    return safeCall(
      () => appServiceProvider.updatePlaylist(request),
    );
  }

  Future<Either<EventResponse, Exception>> createEvent(CreateEventRequest request) {
    return safeCall(
      () => appServiceProvider.createEvent(request),
    );
  }

  Future<Either<PlaylistResponse, Exception>> addToPlayList(
    String playListId,
    String songId,
  ) {
    return safeCall(
      () => appServiceProvider.addToPlayList(playListId, songId),
    );
  }

  Future<Either<List<PlaylistResponse>, Exception>> getPlaylists(
    String query,
    int page,
    int limit,
    String sort,
    String genresId,
    String when,
    int getAll,
  ) {
    return safeCall(
      () => appServiceProvider.getPlaylists(query, page, limit, sort, genresId, when, getAll),
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

  Future<Either<ProfileData, Exception>> getUserProfile(String? userId, {String data = 'info'}) async {
    final userProfile = await safeCall(() => appServiceProvider.getUserProfile(userId, data: data));
    return userProfile.fold(
      (l) {
        if (userId == prefProvider.currentUserId) {
          hiveServiceProvider.saveProfile(l);
        }
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

  CacheFilter? getCacheFilter(String? key) {
    final result = hiveServiceProvider.getCacheFilter(key);
    return result;
  }

  Future saveCacheFilter(String? key, CacheFilter cacheFilter) async {
    hiveServiceProvider.saveCacheFilter(key, cacheFilter);
  }

  Future clearFilter() async {
    await hiveServiceProvider.clearFilter();
  }

  Future<Either<List<ProfileData>, Exception>> getListUsers(String query, String? groupUserId) {
    return safeCall(() => appServiceProvider.getListUsers(query, groupUserId));
  }

  Future<Either<RegisterResponse, Exception>> uploadSong(UploadRequest resultStep2) {
    return safeCall(() => appServiceProvider.uploadSong(resultStep2));
  }

  Future<Either<CreateAlbumResponse, Exception>> uploadAlbum(UploadRequest resultStep2) {
    return safeCall(() => appServiceProvider.uploadAlbum(resultStep2));
  }

  Future<Either<CreateAlbumResponse, Exception>> deleteSongId(String? songId) {
    return safeCall(() => appServiceProvider.deleteSongId(songId));
  }

  Future<Either<CreateAlbumResponse, Exception>> deletedAlbumId(String? songId) {
    return safeCall(() => appServiceProvider.deletedAlbumId(songId));
  }

  Future<Either<List<AtlasCategory>, Exception>> getAtlasCategories() async {
    final result = await safeCall(appServiceProvider.getAtlasCategories);
    return result.fold((categories) {
      hiveServiceProvider.saveCategories(categories);
      return left(categories);
    }, (exception) {
      final categories = hiveServiceProvider.getCachedCategories();
      if (categories.isEmpty) {
        return right(NoCacheDataException(''));
      }
      return left(categories);
    });
  }

  Future<Either<List<AtlasUser>, Exception>> getAtlasUsers(FilterUsersRequest params, {CancelToken? cancel}) async {
    return safeCall(() => appServiceProvider.getAtlasUsers(params, cancel: cancel));
  }

  Future<Either<UserSubscriptionResponse, Exception>> subscribeUser(AtlasUser user) async {
    return safeCall(() => appServiceProvider.subscribeUser(user));
  }

  Future<Either<CreateAlbumResponse, Exception>> editAlbum(UploadRequest resultStep2) {
    return safeCall(() => appServiceProvider.editAlbum(resultStep2));
  }

  Future<Either<CreateAlbumResponse, Exception>> editSong(UploadRequest resultStep2) {
    return safeCall(() => appServiceProvider.editSong(resultStep2));
  }

  Future<Either<List<Country>, Exception>> getAllCountries() async {
    final result = await safeCall(appServiceProvider.getAllCountries);
    return result.fold((countries) {
      hiveServiceProvider.saveCountries(countries);
      return left(countries);
    }, (exception) {
      final countries = hiveServiceProvider.getCachedCountries();
      if (countries.isEmpty) {
        return right(NoCacheDataException(''));
      }
      return left(countries);
    });
  }

  Future<Either<List<EventResponse>, Exception>> getMyDiaryEvents(MyDiaryEventRequest request,
      {CancelToken? cancel}) async {
    return safeCall(() => appServiceProvider.getMyDiaryEvents(request, cancel: cancel));
  }

  Future<Either<List<ProfileData>, Exception>> getListSubscriptions(String? userId, int page, int limit) {
    return safeCall(() => appServiceProvider.getListSubscriptions(userId, page, limit));
  }

  Future<Either<String, Exception>> uploadAvatar(XFile file) {
    return safeCall(() => appServiceProvider.uploadAvatar(file));
  }

  Future<Either<PageTemplateResponse, Exception>> getPageTemplateData({String? userGroupId}) async {
    return safeCall(() => appServiceProvider.getPageTemplateData(userGroupId: userGroupId));
  }

  Future<Either<bool, Exception>> updatePageTemplate(Map<String, dynamic> params) {
    return safeCall(() => appServiceProvider.updatePageTemplate(params));
  }

  Future<Either<UpdateAccountSettingsResponse, Exception>> updateAccountSettings(AccountSettings accountSettings) {
    return safeCall(() => appServiceProvider.updateAccountSettings(accountSettings));
  }

  Future<Either<List<NotificationOption>, Exception>> getAllNotifications() {
    return safeCall(appServiceProvider.getAllNotificationOptions);
  }

  Future<Either<bool, Exception>> updateNotificationData(List<NotificationOption> notifications) {
    return safeCall(() => appServiceProvider.updateNotificationData(notifications));
  }

  Future<Either<List<Video>, Exception>> getVideos(VideoRequest? params) {
    return safeCall(() => appServiceProvider.getVideos(params));
  }

  Future<Either<TimeZoneReponse, Exception>> getAllTimezones() async {
    return safeCall(appServiceProvider.getAllTimezones);
  }

  Future<Either<LanguageResponse, Exception>> getAllSupportedLanguages() async {
    return safeCall(appServiceProvider.getSupportedLanguages);
  }

  Future<Either<ProfileData, Exception>> getMyUserInfo() {
    return safeCall(appServiceProvider.getMyUserInfo);
  }

  Future<Either<PrivacySettingsReponse, Exception>> getPrivacySettings() {
    return safeCall(appServiceProvider.getPrivacySettings);
  }

  Future<Either<PrivacySettingsReponse, Exception>> updatePrivacySettings(List<PrivacySettingItem> items) {
    return safeCall(() => appServiceProvider.updatePrivacySetting(items));
  }

  Future<Exception?> unblockUser(String userId) {
    return appServiceProvider.unblockUser(userId);
  }

  Future<Either<BaseRes?, Exception>> resentEmail(String email, String token) {
    return safeCall(() => appServiceProvider.resentEmail(email, token));
  }

  Future<Either<BaseRes?, Exception>> resetPassword(String newPassword, String code, String token) {
    return safeCall(() => appServiceProvider.resetPassword(newPassword, code, token));
  }

  Future<Either<UniversalSearchReponse?, Exception>> universalSearch({
    required String keyword,
    required int page,
    required UniversalSearchView searchView,
    int limit = 20,
    CancelToken? cancel,
  }) {
    return safeCall(
      () => appServiceProvider.getUniversalSearch(
        keyword: keyword,
        page: page,
        searchView: searchView,
        cancel: cancel,
      ),
    );
  }

  Future<Either<CartResponse, Exception>> getCartItems() {
    return safeCall(appServiceProvider.getAllCartItems);
  }

  Future<Either<bool, Exception>> deleteCartItems(List<String> itemIds) {
    return safeCall(() => appServiceProvider.deleteCartItems(itemIds));
  }

  Future<Either<bool, Exception>> addCartitem(String id) {
    return safeCall(() => appServiceProvider.addCartItem(id));
  }

  String? getCurrency() {
    final profile = hiveServiceProvider.getProfile();
    if (profile != null) {
      return profile.currency;
    }
    return null;
  }

  Future<Either<BaseRes?, Exception>> sendCode(String code, String token) {
    return safeCall(() => appServiceProvider.sendCode(code, token));
  }
}
