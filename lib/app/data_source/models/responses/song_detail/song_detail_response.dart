import 'package:freezed_annotation/freezed_annotation.dart';
part 'song_detail_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SongDetailResponse {
  String? isLiked;
  bool? isFriend;
  String? songId;
  String? viewId;
  String? privacy;
  String? privacyComment;
  String? isFree;
  String? isFeatured;
  String? isSponsor;
  String? albumId;
  String? genreId;
  String? isDj;
  String? userId;
  String? title;
  String? description;
  String? descriptionParsed;
  String? licenseType;
  String? songPath;
  String? serverId;
  String? explicit;
  String? duration;
  String? ordering;
  String? imageServerId;
  String? totalPlay;
  String? totalView;
  String? totalComment;
  String? totalLike;
  String? totalDislike;
  String? totalScore;
  String? totalRating;
  String? totalAttachment;
  String? timeStamp;
  String? moduleId;
  String? itemId;
  String? disableDownload;
  String? isrc;
  String? url;
  String? isDay;
  String? artistId;
  String? lyrics;
  String? cost;
  String? totalDownload;
  String? tags;
  String? itunes;
  String? amazon;
  String? googleplay;
  String? youtube;
  String? soundcloud;
  String? imagePath;
  LabelUser? labelUser;
  String? labelUserId;
  ArtistUser? artistUser;
  String? artistUserId;
  String? collabUser;
  String? collabUserId;
  String? peaksJsonUrl;
  String? genreName;
  String? songTotalComment;
  String? songTotalPlay;
  String? songTimeStamp;
  String? songIsSponsor;
  String? albumUrl;
  bool? isOnProfile;
  String? profileUserId;
  String? profilePageId;
  String? userServerId;
  String? userName;
  String? fullName;
  String? gender;
  String? userImage;
  String? isInvisible;
  String? userGroupId;
  String? languageId;
  String? lastActivity;
  String? birthday;
  String? countryIso;
  String? realPath;
  String? songPath64;
  String? bookmark;

  SongDetailResponse({
    this.isLiked,
    this.isFriend,
    this.songId,
    this.viewId,
    this.privacy,
    this.privacyComment,
    this.isFree,
    this.isFeatured,
    this.isSponsor,
    this.albumId,
    this.genreId,
    this.isDj,
    this.userId,
    this.title,
    this.description,
    this.descriptionParsed,
    this.licenseType,
    this.songPath,
    this.serverId,
    this.explicit,
    this.duration,
    this.ordering,
    this.imageServerId,
    this.totalPlay,
    this.totalView,
    this.totalComment,
    this.totalLike,
    this.totalDislike,
    this.totalScore,
    this.totalRating,
    this.totalAttachment,
    this.timeStamp,
    this.moduleId,
    this.itemId,
    this.disableDownload,
    this.isrc,
    this.url,
    this.isDay,
    this.artistId,
    this.lyrics,
    this.cost,
    this.totalDownload,
    this.tags,
    this.itunes,
    this.amazon,
    this.googleplay,
    this.youtube,
    this.soundcloud,
    this.imagePath,
    this.labelUser,
    this.labelUserId,
    this.artistUser,
    this.artistUserId,
    this.collabUser,
    this.collabUserId,
    this.peaksJsonUrl,
    this.genreName,
    this.songTotalComment,
    this.songTotalPlay,
    this.songTimeStamp,
    this.songIsSponsor,
    this.albumUrl,
    this.isOnProfile,
    this.profileUserId,
    this.profilePageId,
    this.userServerId,
    this.userName,
    this.fullName,
    this.gender,
    this.userImage,
    this.isInvisible,
    this.userGroupId,
    this.languageId,
    this.lastActivity,
    this.birthday,
    this.countryIso,
    this.realPath,
    this.songPath64,
    this.bookmark,
  });

  factory SongDetailResponse.fromJson(Map<String, dynamic> json) => _$SongDetailResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ArtistUser {
  String? userId;
  String? profilePageId;
  String? userServerId;
  String? userName;
  String? fullName;
  String? gender;
  String? userImage;
  String? isInvisible;
  String? userGroupId;
  String? languageId;
  String? lastActivity;
  String? birthday;
  String? countryIso;

  ArtistUser({
    this.userId,
    this.profilePageId,
    this.userServerId,
    this.userName,
    this.fullName,
    this.gender,
    this.userImage,
    this.isInvisible,
    this.userGroupId,
    this.languageId,
    this.lastActivity,
    this.birthday,
    this.countryIso,
  });

  factory ArtistUser.fromJson(Map<String, dynamic> json) => _$ArtistUserFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LabelUser {
  String? userId;
  String? profilePageId;
  String? userServerId;
  String? userName;
  String? fullName;
  String? gender;
  String? userImage;
  String? isInvisible;
  String? userGroupId;
  String? languageId;
  String? lastActivity;
  String? birthday;
  String? countryIso;

  LabelUser({
    this.userId,
    this.profilePageId,
    this.userServerId,
    this.userName,
    this.fullName,
    this.gender,
    this.userImage,
    this.isInvisible,
    this.userGroupId,
    this.languageId,
    this.lastActivity,
    this.birthday,
    this.countryIso,
  });

  factory LabelUser.fromJson(Map<String, dynamic> json) => _$LabelUserFromJson(json);
}
