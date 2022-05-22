// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:audio_cult/app/base/index_walker.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AtlasUserResponse {
  String? status;
  List<AtlasUser>? data;

  AtlasUserResponse();

  AtlasUserResponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    status = iw['status'].get();
    data = (json['data'] as List<dynamic>)
        .map(
          (e) => AtlasUser.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}

class AtlasUser {
  String? userId;
  String? userGroupId;
  String? userName;
  String? fullName;
  String? userImage;
  String? coverPhoto;
  int? subscriptionCount;
  String? userGroupTitle;
  bool? isSubscribed;
  String? locationName;

  AtlasUser();

  AtlasUser.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    userId = iw['user_id'].get();
    userGroupId = iw['user_group_id'].get();
    userName = iw['user_name'].get();
    fullName = iw['full_name'].get();
    userImage = iw['user_image'].get();
    coverPhoto = iw['cover_photo'].get();
    subscriptionCount = iw['subscription_count'].get();
    userGroupTitle = iw['user_group_title'].get();
    isSubscribed = iw['is_subscribed'].get();
    locationName = iw['location_name'].get();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'user_group_id': userGroupId,
      'user_name': userName,
      'full_name': fullName,
      'user_image': userImage,
      'cover_photo': coverPhoto,
      'subscription_count': subscriptionCount,
      'user_group_title': userGroupTitle,
      'is_subscribed': isSubscribed,
      'location_name': locationName,
    };
  }

  void subscribe() {
    isSubscribed = true;
    subscriptionCount = (subscriptionCount ?? 0) + 1;
  }

  void unsubscribe() {
    isSubscribed = false;
    subscriptionCount = (subscriptionCount ?? 0) - 1;
  }

  @override
  String toString() {
    return 'fullname:${fullName} - userId:${userId} - subscriptionCount:${subscriptionCount} - isSubScription:${isSubscribed}';
  }
}
