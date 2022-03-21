// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_icon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionIconResponse _$ReactionIconResponseFromJson(
        Map<String, dynamic> json) =>
    ReactionIconResponse(
      iconId: json['icon_id'] as String?,
      name: json['name'] as String?,
      timeStamp: json['time_stamp'] as String?,
      ordering: json['ordering'] as String?,
      imagePath: json['image_path'] as String?,
      isDefault: json['is_default'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$ReactionIconResponseToJson(
        ReactionIconResponse instance) =>
    <String, dynamic>{
      'icon_id': instance.iconId,
      'name': instance.name,
      'time_stamp': instance.timeStamp,
      'ordering': instance.ordering,
      'image_path': instance.imagePath,
      'is_default': instance.isDefault,
      'color': instance.color,
    };
