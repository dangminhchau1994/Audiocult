import 'package:freezed_annotation/freezed_annotation.dart';

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
class Album with _$Album {
  factory Album({
    bool? isLiked,
    String? userId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_name') String? userName,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'full_name') String? fullName,
    String? userImage,
    String? isInvisible,
    String? albumId,
    String? viewId,
    String? privacy,
    String? privacyComment,
    String? isFeatured,
    String? isSponsor,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'name') String? name,
    String? year,
    String? genreId,
    String? isDj,
    String? licenseType,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image_path') String? imagePath,
    String? serverId,
    String? totalTrack,
    String? totalPlay,
    String? totalComment,
    String? totalView,
    String? totalLike,
    String? totalDislike,
    String? totalScore,
    String? totalRating,
    String? totalAttachment,
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
    String? labelUser,
    String? labelUserId,
    String? artistUser,
    String? artistUserId,
    String? collabUser,
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