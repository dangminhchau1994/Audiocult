// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReasonResponse _$ReasonResponseFromJson(Map<String, dynamic> json) =>
    ReasonResponse(
      reasonId: json['reason_id'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ReasonResponseToJson(ReasonResponse instance) =>
    <String, dynamic>{
      'reason_id': instance.reasonId,
      'message': instance.message,
    };
