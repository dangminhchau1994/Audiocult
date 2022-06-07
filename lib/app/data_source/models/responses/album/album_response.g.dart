// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AlbumResponse _$$_AlbumResponseFromJson(Map<String, dynamic> json) =>
    _$_AlbumResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      error: json['error'],
    );

Map<String, dynamic> _$$_AlbumResponseToJson(_$_AlbumResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
      'error': instance.error,
    };

_$_LastIcon _$$_LastIconFromJson(Map<String, dynamic> json) => _$_LastIcon(
      likeTypeId: json['like_type_id'] as String?,
      imagePath: json['image_path'] as String?,
      countIcon: json['count_icon'] as String?,
    );

Map<String, dynamic> _$$_LastIconToJson(_$_LastIcon instance) =>
    <String, dynamic>{
      'like_type_id': instance.likeTypeId,
      'image_path': instance.imagePath,
      'count_icon': instance.countIcon,
    };

_$_Album _$$_AlbumFromJson(Map<String, dynamic> json) => _$_Album(
      isLiked: json['isLiked'] as bool?,
      userId: json['userId'] as String?,
      userName: json['user_name'] as String?,
      lastIcon: json['last_icon'] == null
          ? null
          : LastIcon.fromJson(json['last_icon'] as Map<String, dynamic>),
      fullName: json['full_name'] as String?,
      userImage: json['userImage'] as String?,
      isInvisible: json['isInvisible'] as String?,
      albumId: json['album_id'] as String?,
      viewId: json['viewId'] as String?,
      privacy: json['privacy'] as String?,
      privacyComment: json['privacyComment'] as String?,
      isFeatured: json['isFeatured'] as String?,
      isSponsor: json['isSponsor'] as String?,
      name: json['name'] as String?,
      year: json['year'] as String?,
      genreId: json['genre_id'] as String?,
      isDj: json['isDj'] as String?,
      licenseType: json['license_type'] as String?,
      imagePath: json['image_path'] as String?,
      serverId: json['serverId'] as String?,
      totalTrack: json['totalTrack'] as String?,
      totalPlay: json['total_play'] as String?,
      totalComment: json['total_comment'] as String?,
      totalView: json['totalView'] as String?,
      totalLike: json['total_like'] as String?,
      totalDislike: json['totalDislike'] as String?,
      totalScore: json['totalScore'] as String?,
      totalRating: json['totalRating'] as String?,
      totalAttachment: json['total_attachment'] as String?,
      timeStamp: json['time_stamp'] as String?,
      moduleId: json['moduleId'],
      itemId: json['itemId'] as String?,
      isDay: json['isDay'],
      artistId: json['artistId'] as String?,
      itunes: json['itunes'] as String?,
      amazon: json['amazon'] as String?,
      googleplay: json['googleplay'] as String?,
      youtube: json['youtube'],
      soundcloud: json['soundcloud'] as String?,
      labelUser: json['label_user'] == null
          ? null
          : ProfileData.fromJson(json['label_user'] as Map<String, dynamic>),
      labelUserId: json['labelUserId'] as String?,
      artistUser: json['artist_user'] == null
          ? null
          : ProfileData.fromJson(json['artist_user'] as Map<String, dynamic>),
      artistUserId: json['artistUserId'] as String?,
      collabUser: json['collab_user'] == null
          ? null
          : ProfileData.fromJson(json['collab_user'] as Map<String, dynamic>),
      collabUserId: json['collabUserId'] as String?,
      canEdit: json['canEdit'] as bool?,
      canAddSong: json['canAddSong'] as bool?,
      canDelete: json['canDelete'] as bool?,
      canPurchaseSponsor: json['canPurchaseSponsor'] as bool?,
      canSponsor: json['canSponsor'] as bool?,
      canFeature: json['canFeature'] as bool?,
      hasPermission: json['hasPermission'] as bool?,
    );

Map<String, dynamic> _$$_AlbumToJson(_$_Album instance) => <String, dynamic>{
      'isLiked': instance.isLiked,
      'userId': instance.userId,
      'user_name': instance.userName,
      'last_icon': instance.lastIcon,
      'full_name': instance.fullName,
      'userImage': instance.userImage,
      'isInvisible': instance.isInvisible,
      'album_id': instance.albumId,
      'viewId': instance.viewId,
      'privacy': instance.privacy,
      'privacyComment': instance.privacyComment,
      'isFeatured': instance.isFeatured,
      'isSponsor': instance.isSponsor,
      'name': instance.name,
      'year': instance.year,
      'genre_id': instance.genreId,
      'isDj': instance.isDj,
      'license_type': instance.licenseType,
      'image_path': instance.imagePath,
      'serverId': instance.serverId,
      'totalTrack': instance.totalTrack,
      'total_play': instance.totalPlay,
      'total_comment': instance.totalComment,
      'totalView': instance.totalView,
      'total_like': instance.totalLike,
      'totalDislike': instance.totalDislike,
      'totalScore': instance.totalScore,
      'totalRating': instance.totalRating,
      'total_attachment': instance.totalAttachment,
      'time_stamp': instance.timeStamp,
      'moduleId': instance.moduleId,
      'itemId': instance.itemId,
      'isDay': instance.isDay,
      'artistId': instance.artistId,
      'itunes': instance.itunes,
      'amazon': instance.amazon,
      'googleplay': instance.googleplay,
      'youtube': instance.youtube,
      'soundcloud': instance.soundcloud,
      'label_user': instance.labelUser,
      'labelUserId': instance.labelUserId,
      'artist_user': instance.artistUser,
      'artistUserId': instance.artistUserId,
      'collab_user': instance.collabUser,
      'collabUserId': instance.collabUserId,
      'canEdit': instance.canEdit,
      'canAddSong': instance.canAddSong,
      'canDelete': instance.canDelete,
      'canPurchaseSponsor': instance.canPurchaseSponsor,
      'canSponsor': instance.canSponsor,
      'canFeature': instance.canFeature,
      'hasPermission': instance.hasPermission,
    };
