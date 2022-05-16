// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atlas_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtlasUserResponse _$AtlasUserResponseFromJson(Map<String, dynamic> json) =>
    AtlasUserResponse()
      ..status = json['status'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => AtlasUser.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AtlasUserResponseToJson(AtlasUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

AtlasUser _$AtlasUserFromJson(Map<String, dynamic> json) => AtlasUser()
  ..userId = json['user_id'] as String?
  ..userGroupId = json['user_group_id'] as String?
  ..userName = json['user_name'] as String?
  ..fullName = json['full_name'] as String?
  ..userImage = json['user_image'] as String?
  ..coverPhoto = json['cover_photo'] as String?
  ..subscriptionCount = json['subscription_count'] as String?
  ..userGroupTitle = json['user_group_title'] as String?
  ..isSubscribed = json['is_subscribed'] as bool?
  ..locationName = json['location_name'] as String?;

Map<String, dynamic> _$AtlasUserToJson(AtlasUser instance) => <String, dynamic>{
      'user_id': instance.userId,
      'user_group_id': instance.userGroupId,
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'user_image': instance.userImage,
      'cover_photo': instance.coverPhoto,
      'subscription_count': instance.subscriptionCount,
      'user_group_title': instance.userGroupTitle,
      'is_subscribed': instance.isSubscribed,
      'location_name': instance.locationName,
    };
