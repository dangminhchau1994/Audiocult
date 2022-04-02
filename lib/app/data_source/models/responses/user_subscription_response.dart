import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_subscription_response.g.dart';

@JsonSerializable()
class UserSubscriptionResponse {
  RequestStatus? status;
  String? message;
  ErrorReponse? error;

  UserSubscriptionResponse();

  factory UserSubscriptionResponse.fromJson(Map<String, dynamic> json) => _$UserSubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSubscriptionResponseToJson(this);

  @override
  String toString() {
    return '${status?.value} - $message - ${error?.message}';
  }
}

@JsonSerializable()
class ErrorReponse {
  String? message;

  ErrorReponse();

  factory ErrorReponse.fromJson(Map<String, dynamic> json) => _$ErrorReponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorReponseToJson(this);
}
