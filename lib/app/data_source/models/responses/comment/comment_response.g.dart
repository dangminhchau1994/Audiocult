// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      isLiked: json['is_liked'] as bool?,
      commentId: json['comment_id'] as String?,
      parentId: json['parent_id'] as String?,
      typeId: json['type_id'] as String?,
      itemId: json['item_id'] as String?,
      userId: json['user_id'] as String?,
      ownerUserId: json['owner_user_id'] as String?,
      timeStamp: json['time_stamp'] as String?,
      childTotal: json['child_total'] as String?,
      totalLike: json['total_like'] as String?,
      text: json['text'] as String?,
      userName: json['user_name'] as String?,
      fullName: json['full_name'] as String?,
      userImage: json['user_image'] as String?,
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'is_liked': instance.isLiked,
      'comment_id': instance.commentId,
      'parent_id': instance.parentId,
      'type_id': instance.typeId,
      'item_id': instance.itemId,
      'user_id': instance.userId,
      'owner_user_id': instance.ownerUserId,
      'time_stamp': instance.timeStamp,
      'child_total': instance.childTotal,
      'total_like': instance.totalLike,
      'text': instance.text,
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'user_image': instance.userImage,
    };
