// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCategoryResponse _$EventCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    EventCategoryResponse(
      categoryId: json['category_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      url: json['url'] as String?,
      sub: json['sub'] as List<dynamic>?,
    );

Map<String, dynamic> _$EventCategoryResponseToJson(
        EventCategoryResponse instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'icon': instance.icon,
      'url': instance.url,
      'sub': instance.sub,
    };
