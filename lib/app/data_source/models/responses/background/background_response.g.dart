// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackgroundResponse _$BackgroundResponseFromJson(Map<String, dynamic> json) =>
    BackgroundResponse(
      collectionId: json['collection_id'] as String?,
      title: json['title'] as String?,
      isActive: json['is_active'] as String?,
      isDefault: json['is_default'] as String?,
      isDeleted: json['is_deleted'] as String?,
      mainImageId: json['main_image_id'] as String?,
      timeStamp: json['time_stamp'] as String?,
      viewId: json['view_id'] as String?,
      totalBackground: json['total_background'] as String?,
      backgroundsList: (json['backgrounds_list'] as List<dynamic>?)
          ?.map((e) => BackgroundsList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BackgroundResponseToJson(BackgroundResponse instance) =>
    <String, dynamic>{
      'collection_id': instance.collectionId,
      'title': instance.title,
      'is_active': instance.isActive,
      'is_default': instance.isDefault,
      'is_deleted': instance.isDeleted,
      'main_image_id': instance.mainImageId,
      'time_stamp': instance.timeStamp,
      'view_id': instance.viewId,
      'total_background': instance.totalBackground,
      'backgrounds_list': instance.backgroundsList,
    };

BackgroundsList _$BackgroundsListFromJson(Map<String, dynamic> json) =>
    BackgroundsList(
      backgroundId: json['background_id'] as String?,
      collectionId: json['collection_id'] as String?,
      imagePath: json['image_path'] as String?,
      serverId: json['server_id'] as String?,
      ordering: json['ordering'] as String?,
      isDeleted: json['is_deleted'] as String?,
      timeStamp: json['time_stamp'] as String?,
      viewId: json['view_id'] as String?,
      fullPath: json['full_path'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$BackgroundsListToJson(BackgroundsList instance) =>
    <String, dynamic>{
      'background_id': instance.backgroundId,
      'collection_id': instance.collectionId,
      'image_path': instance.imagePath,
      'server_id': instance.serverId,
      'ordering': instance.ordering,
      'is_deleted': instance.isDeleted,
      'time_stamp': instance.timeStamp,
      'view_id': instance.viewId,
      'full_path': instance.fullPath,
      'image_url': instance.imageUrl,
    };
