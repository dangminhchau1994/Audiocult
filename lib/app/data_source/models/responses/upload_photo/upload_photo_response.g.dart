// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadPhotoResponse _$UploadPhotoResponseFromJson(Map<String, dynamic> json) =>
    UploadPhotoResponse(
      isLiked: json['is_liked'] as bool?,
      userId: json['user_id'] as String?,
      photoId: json['photo_id'] as String?,
      albumId: json['album_id'] as String?,
      moduleId: json['module_id'],
      groupId: json['group_id'] as String?,
      privacy: json['privacy'] as String?,
      privacyComment: json['privacy_comment'] as String?,
      title: json['title'] as String?,
      timeStamp: json['time_stamp'] as String?,
      isFeatured: json['is_featured'] as String?,
      isSponsor: json['is_sponsor'] as String?,
      categories: json['categories'],
      bookmarkUrl: json['bookmark_url'] as String?,
      photoUrl: json['photo_url'] as String?,
    );

Map<String, dynamic> _$UploadPhotoResponseToJson(
        UploadPhotoResponse instance) =>
    <String, dynamic>{
      'is_liked': instance.isLiked,
      'user_id': instance.userId,
      'photo_id': instance.photoId,
      'album_id': instance.albumId,
      'module_id': instance.moduleId,
      'group_id': instance.groupId,
      'privacy': instance.privacy,
      'privacy_comment': instance.privacyComment,
      'title': instance.title,
      'time_stamp': instance.timeStamp,
      'is_featured': instance.isFeatured,
      'is_sponsor': instance.isSponsor,
      'categories': instance.categories,
      'bookmark_url': instance.bookmarkUrl,
      'photo_url': instance.photoUrl,
    };
