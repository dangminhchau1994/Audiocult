import 'package:freezed_annotation/freezed_annotation.dart';
part 'song_response.freezed.dart';
part 'song_response.g.dart';

@freezed
class SongResponse with _$SongResponse {
  factory SongResponse({
    String? status,
    List<Song>? data,
    String? message,
    String? error,
  }) = _SongResponse;

  factory SongResponse.fromJson(Map<String, dynamic> json) => _$SongResponseFromJson(json);
}

@freezed
class Song with _$Song {
  factory Song({
    String? userId,
    String? artistTitle,
    String? albumName,
    String? songId,
    String? viewId,
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
    String? licenseType,
    String? songPath,
    String? explicit,
    int? duration,
    String? totalPlay,
    String? totalView,
    String? totalComment,
    String? totalLike,
    String? totalDislike,
    String? totalScore,
    String? totalRating,
    String? totalAttachment,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'time_stamp') String? timeStamp,
    String? lyrics,
    String? cost,
    String? totalDownload,
    String? tags,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image_path') String? imagePath,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist_user') ArtistUser? artistUser,
    String? peaksJsonUrl,
    int? noPhoto,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
}

@freezed
class ArtistUser with _$ArtistUser {
  factory ArtistUser({
    String? userId,
    String? profilePageId,
    String? userServerId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_name') String? userName,
    String? fullName,
    String? gender,
    String? userImage,
    String? isInvisible,
    String? userGroupId,
    String? languageId,
    String? lastActivity,
    String? birthday,
    String? countryIso,
  }) = _ArtistUser;

  factory ArtistUser.fromJson(Map<String, dynamic> json) => _$ArtistUserFromJson(json);
}
