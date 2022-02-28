// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SongResponse _$$_SongResponseFromJson(Map<String, dynamic> json) =>
    _$_SongResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$_SongResponseToJson(_$_SongResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
      'error': instance.error,
    };

_$_Song _$$_SongFromJson(Map<String, dynamic> json) => _$_Song(
      userId: json['userId'] as String?,
      artistTitle: json['artistTitle'] as String?,
      albumName: json['albumName'] as String?,
      songId: json['songId'] as String?,
      viewId: json['viewId'] as String?,
      privacy: json['privacy'] as String?,
      privacyComment: json['privacyComment'] as String?,
      isFree: json['isFree'] as String?,
      isFeatured: json['isFeatured'] as String?,
      isSponsor: json['isSponsor'] as String?,
      albumId: json['albumId'] as String?,
      genreId: json['genreId'] as String?,
      isDj: json['isDj'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      licenseType: json['licenseType'] as String?,
      songPath: json['songPath'] as String?,
      explicit: json['explicit'] as String?,
      duration: json['duration'] as int?,
      totalPlay: json['totalPlay'] as String?,
      totalView: json['totalView'] as String?,
      totalComment: json['totalComment'] as String?,
      totalLike: json['totalLike'] as String?,
      totalDislike: json['totalDislike'] as String?,
      totalScore: json['totalScore'] as String?,
      totalRating: json['totalRating'] as String?,
      totalAttachment: json['totalAttachment'] as String?,
      timeStamp: json['time_stamp'] as String?,
      lyrics: json['lyrics'] as String?,
      cost: json['cost'] as String?,
      totalDownload: json['totalDownload'] as String?,
      tags: json['tags'] as String?,
      imagePath: json['image_path'] as String?,
      artistUser: json['artist_user'] == null
          ? null
          : ArtistUser.fromJson(json['artist_user'] as Map<String, dynamic>),
      peaksJsonUrl: json['peaksJsonUrl'] as String?,
      noPhoto: json['noPhoto'] as int?,
    );

Map<String, dynamic> _$$_SongToJson(_$_Song instance) => <String, dynamic>{
      'userId': instance.userId,
      'artistTitle': instance.artistTitle,
      'albumName': instance.albumName,
      'songId': instance.songId,
      'viewId': instance.viewId,
      'privacy': instance.privacy,
      'privacyComment': instance.privacyComment,
      'isFree': instance.isFree,
      'isFeatured': instance.isFeatured,
      'isSponsor': instance.isSponsor,
      'albumId': instance.albumId,
      'genreId': instance.genreId,
      'isDj': instance.isDj,
      'title': instance.title,
      'description': instance.description,
      'licenseType': instance.licenseType,
      'songPath': instance.songPath,
      'explicit': instance.explicit,
      'duration': instance.duration,
      'totalPlay': instance.totalPlay,
      'totalView': instance.totalView,
      'totalComment': instance.totalComment,
      'totalLike': instance.totalLike,
      'totalDislike': instance.totalDislike,
      'totalScore': instance.totalScore,
      'totalRating': instance.totalRating,
      'totalAttachment': instance.totalAttachment,
      'time_stamp': instance.timeStamp,
      'lyrics': instance.lyrics,
      'cost': instance.cost,
      'totalDownload': instance.totalDownload,
      'tags': instance.tags,
      'image_path': instance.imagePath,
      'artist_user': instance.artistUser,
      'peaksJsonUrl': instance.peaksJsonUrl,
      'noPhoto': instance.noPhoto,
    };

_$_ArtistUser _$$_ArtistUserFromJson(Map<String, dynamic> json) =>
    _$_ArtistUser(
      userId: json['userId'] as String?,
      profilePageId: json['profilePageId'] as String?,
      userServerId: json['userServerId'] as String?,
      userName: json['user_name'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      userImage: json['userImage'] as String?,
      isInvisible: json['isInvisible'] as String?,
      userGroupId: json['userGroupId'] as String?,
      languageId: json['languageId'] as String?,
      lastActivity: json['lastActivity'] as String?,
      birthday: json['birthday'] as String?,
      countryIso: json['countryIso'] as String?,
    );

Map<String, dynamic> _$$_ArtistUserToJson(_$_ArtistUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'profilePageId': instance.profilePageId,
      'userServerId': instance.userServerId,
      'user_name': instance.userName,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'userImage': instance.userImage,
      'isInvisible': instance.isInvisible,
      'userGroupId': instance.userGroupId,
      'languageId': instance.languageId,
      'lastActivity': instance.lastActivity,
      'birthday': instance.birthday,
      'countryIso': instance.countryIso,
    };
