// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubscriptionResponse _$UserSubscriptionResponseFromJson(
        Map<String, dynamic> json) =>
    UserSubscriptionResponse()
      ..status = $enumDecodeNullable(_$RequestStatusEnumMap, json['status'])
      ..message = json['message'] as String?
      ..error = json['error'] == null
          ? null
          : ErrorReponse.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$UserSubscriptionResponseToJson(
        UserSubscriptionResponse instance) =>
    <String, dynamic>{
      'status': _$RequestStatusEnumMap[instance.status],
      'message': instance.message,
      'error': instance.error,
    };

const _$RequestStatusEnumMap = {
  RequestStatus.success: 'success',
  RequestStatus.failed: 'failed',
};

ErrorReponse _$ErrorReponseFromJson(Map<String, dynamic> json) =>
    ErrorReponse()..message = json['message'] as String?;

Map<String, dynamic> _$ErrorReponseToJson(ErrorReponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
