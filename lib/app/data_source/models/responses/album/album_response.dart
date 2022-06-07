import 'package:freezed_annotation/freezed_annotation.dart';

import '../profile_data.dart';

part 'album_response.freezed.dart';
part 'album_response.g.dart';

@freezed
class AlbumResponse with _$AlbumResponse {
  factory AlbumResponse({
    String? status,
    List<Album>? data,
    String? message,
    dynamic error,
  }) = _AlbumResponse;

  factory AlbumResponse.fromJson(Map<String, dynamic> json) => _$AlbumResponseFromJson(json);
}

@freezed
class LastIcon with _$LastIcon {
  factory LastIcon({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'like_type_id') String? likeTypeId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image_path') String? imagePath,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'count_icon') String? countIcon,
  }) = _LastIcon;

  factory LastIcon.fromJson(Map<String, dynamic> json) => _$LastIconFromJson(json);
}

@freezed
class Album with _$Album {
  factory Album({
    bool? isLiked,
    String? userId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_name') String? userName,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'last_icon') LastIcon? lastIcon,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'full_name') String? fullName,
    String? userImage,
    String? isInvisible,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'album_id') String? albumId,
    String? viewId,
    String? privacy,
    String? privacyComment,
    String? isFeatured,
    String? isSponsor,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'name') String? name,
    String? year,
    @JsonKey(name: 'genre_id') String? genreId,
    String? isDj,
    @JsonKey(name: 'license_type') String? licenseType,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image_path') String? imagePath,
    String? serverId,
    String? totalTrack,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_play') String? totalPlay,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_comment') String? totalComment,
    String? totalView,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_like') String? totalLike,
    String? totalDislike,
    String? totalScore,
    String? totalRating,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_attachment') String? totalAttachment,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'time_stamp') String? timeStamp,
    dynamic moduleId,
    String? itemId,
    dynamic isDay,
    String? artistId,
    String? itunes,
    String? amazon,
    String? googleplay,
    dynamic youtube,
    String? soundcloud,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'label_user') ProfileData? labelUser,
    String? labelUserId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist_user') ProfileData? artistUser,
    String? artistUserId,
    @JsonKey(name: 'collab_user') ProfileData? collabUser,
    String? collabUserId,
    bool? canEdit,
    bool? canAddSong,
    bool? canDelete,
    bool? canPurchaseSponsor,
    bool? canSponsor,
    bool? canFeature,
    bool? hasPermission,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}
