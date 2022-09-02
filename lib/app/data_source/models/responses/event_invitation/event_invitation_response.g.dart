// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_invitation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventInvitationResponse _$EventInvitationResponseFromJson(
        Map<String, dynamic> json) =>
    EventInvitationResponse(
      userId: json['user_id'] as String?,
      profilePageId: json['profile_page_id'] as String?,
      userServerId: json['user_server_id'] as String?,
      userName: json['user_name'] as String?,
      fullName: json['full_name'] as String?,
      gender: json['gender'] as String?,
      isChecked: json['is_checked'] as bool? ?? false,
      userImage: json['user_image'] as String?,
      isInvisible: json['is_invisible'] as String?,
      userGroupId: json['user_group_id'] as String?,
      languageId: json['language_id'] as String?,
      lastActivity: json['last_activity'] as String?,
      birthday: json['birthday'],
      countryIso: json['country_iso'] as String?,
      isActive: json['is_active'],
    );

Map<String, dynamic> _$EventInvitationResponseToJson(
        EventInvitationResponse instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'profile_page_id': instance.profilePageId,
      'user_server_id': instance.userServerId,
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'gender': instance.gender,
      'user_image': instance.userImage,
      'is_invisible': instance.isInvisible,
      'user_group_id': instance.userGroupId,
      'language_id': instance.languageId,
      'last_activity': instance.lastActivity,
      'birthday': instance.birthday,
      'is_checked': instance.isChecked,
      'country_iso': instance.countryIso,
      'is_active': instance.isActive,
    };
