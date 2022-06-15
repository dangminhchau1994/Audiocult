import 'package:freezed_annotation/freezed_annotation.dart';
part 'playlist_response.freezed.dart';
part 'playlist_response.g.dart';

@freezed
class PlaylistResponse with _$PlaylistResponse {
  factory PlaylistResponse({
    String? isLiked,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_id') String? userId,
    String? profilePageId,
    String? userServerId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_name') String? userName,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'full_name') String? fullName,
    String? gender,
    String? userImage,
    String? isInvisible,
    String? userGroupId,
    String? languageId,
    String? lastActivity,
    String? birthday,
    String? countryIso,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'playlist_id') String? playlistId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'title') String? title,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'description') String? description,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'time_stamp') String? timeStamp,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_likes') String? totalLikes,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_comments') String? totalComments,
    bool? isFeatured,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image_path') String? imagePath,
    bool? isDay,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_view') String? totalView,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'last_icon') LastIcon? lastIcon,
    String? artistId,
    List<Songs>? songs,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'count_songs') int? countSongs,
  }) = _PlaylistResponse;

  factory PlaylistResponse.fromJson(Map<String, dynamic> json) => _$PlaylistResponseFromJson(json);
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
class Songs with _$Songs {
  factory Songs({
    String? id,
    String? songId,
    String? playlistId,
    String? userId,
    String? timeStamp,
    String? profilePageId,
    String? serverId,
    String? userGroupId,
    String? statusId,
    String? viewId,
    String? userName,
    String? fullName,
    String? password,
    String? passwordSalt,
    String? email,
    String? gender,
    String? birthday,
    String? birthdaySearch,
    String? countryIso,
    String? languageId,
    String? styleId,
    dynamic timeZone,
    String? dstCheck,
    String? joined,
    String? lastLogin,
    String? lastActivity,
    String? userImage,
    String? hideTip,
    dynamic status,
    String? footerBar,
    String? inviteUserId,
    String? imBeep,
    String? imHide,
    String? isInvisible,
    String? totalSpam,
    String? lastIpAddress,
    String? feedSort,
    String? customGender,
    String? totalProfileLike,
    String? isVerified,
    String? reminderDate,
    double? blogRating,
    String? privacy,
    String? privacyComment,
    String? isFree,
    String? isFeatured,
    String? isSponsor,
    String? albumId,
    String? genreId,
    String? isDj,
    String? title,
    String? description,
    String? descriptionParsed,
    String? licenseType,
    String? songPath,
    String? explicit,
    String? duration,
    String? ordering,
    String? imageServerId,
    String? totalPlay,
    String? totalView,
    String? totalComment,
    String? totalLike,
    String? totalDislike,
    String? totalScore,
    String? totalRating,
    String? totalAttachment,
    int? moduleId,
    String? itemId,
    String? disableDownload,
    String? isrc,
    String? url,
    String? isDay,
    String? artistId,
    String? lyrics,
    String? cost,
    int? totalDownload,
    String? tags,
    String? itunes,
    String? amazon,
    String? googleplay,
    String? youtube,
    String? soundcloud,
    String? imagePath,
    String? labelUser,
    String? labelUserId,
    String? artistUser,
    String? artistUserId,
    String? collabUser,
    String? collabUserId,
    String? peaksJsonUrl,
    String? titleTruncate,
    int? noPhoto,
  }) = _Songs;

  factory Songs.fromJson(Map<String, dynamic> json) => _$SongsFromJson(json);
}
