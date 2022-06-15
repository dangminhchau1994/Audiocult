// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_playlist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePlaylistResponse _$UpdatePlaylistResponseFromJson(
        Map<String, dynamic> json) =>
    UpdatePlaylistResponse(
      title: json['title'] as String?,
      imagePath: json['image_path'] as String?,
      editId: json['edit_id'] as String?,
      error: json['error'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UpdatePlaylistResponseToJson(
        UpdatePlaylistResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image_path': instance.imagePath,
      'edit_id': instance.editId,
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
    };
