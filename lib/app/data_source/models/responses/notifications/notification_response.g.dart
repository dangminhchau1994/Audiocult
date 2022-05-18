// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      date: json['date'] as String?,
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => Notification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'date': instance.date,
      'notifications': instance.notifications,
    };

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      notificationId: json['notification_id'] as String?,
      typeId: json['type_id'] as String?,
      itemId: json['item_id'] as String?,
      userId: json['user_id'] as String?,
      ownerUserId: json['owner_user_id'] as String?,
      isSeen: json['is_seen'] as String?,
      isRead: json['is_read'] as String?,
      timeStamp: json['time_stamp'] as String?,
      itemUserId: json['item_user_id'] as String?,
      userServerId: json['user_server_id'] as String?,
      userName: json['user_name'] as String?,
      fullName: json['full_name'] as String?,
      gender: json['gender'] as String?,
      userImage: json['user_image'] as String?,
      link: json['link'] as String?,
      message: json['message'] as String?,
      customIcon: json['custom_icon'] as String?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'notification_id': instance.notificationId,
      'type_id': instance.typeId,
      'item_id': instance.itemId,
      'user_id': instance.userId,
      'owner_user_id': instance.ownerUserId,
      'is_seen': instance.isSeen,
      'is_read': instance.isRead,
      'time_stamp': instance.timeStamp,
      'item_user_id': instance.itemUserId,
      'user_server_id': instance.userServerId,
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'gender': instance.gender,
      'user_image': instance.userImage,
      'link': instance.link,
      'message': instance.message,
      'custom_icon': instance.customIcon,
    };
