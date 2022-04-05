import 'package:json_annotation/json_annotation.dart';

part 'atlas_user.g.dart';

@JsonSerializable()
class AtlasUserResponse {
  String? status;
  List<AtlasUser>? data;

  AtlasUserResponse();

  factory AtlasUserResponse.fromJson(Map<String, dynamic> json) => _$AtlasUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AtlasUserResponseToJson(this);
}

@JsonSerializable()
class AtlasUser {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_group_id')
  String? userGroupId;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'full_name')
  String? fullName;
  @JsonKey(name: 'user_image')
  String? userImage;
  @JsonKey(name: 'cover_photo')
  String? coverPhoto;
  @JsonKey(name: 'subscription_count')
  int? subscriptionCount;
  @JsonKey(name: 'user_group_title')
  String? userGroupTitle;
  @JsonKey(name: 'is_subscribed')
  bool? isSubcribed;
  @JsonKey(name: 'location_name')
  String? locationName;

  AtlasUser();

  factory AtlasUser.fromJson(Map<String, dynamic> json) => _$AtlasUserFromJson(json);

  Map<String, dynamic> toJson() => _$AtlasUserToJson(this);

  void subscribe() {
    isSubcribed = true;
    subscriptionCount = (subscriptionCount ?? 0) + 1;
  }

  void unsubcribe() {
    isSubcribed = false;
    subscriptionCount = (subscriptionCount ?? 0) - 1;
  }

  @override
  String toString() {
    return 'fullname:${fullName} - userId:${userId} - subscriptionCount:${subscriptionCount} - isSubScription:${isSubcribed}';
  }
}
