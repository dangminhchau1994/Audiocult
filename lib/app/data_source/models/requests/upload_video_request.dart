import 'dart:io';

class UploadVideoRequest {
  File? video;
  String? title;
  String? url;
  String? statusInfo;
  String? latLng;
  String? locationName;
  String? taggedFriends;
  int? privacy;

  UploadVideoRequest({
    this.video,
    this.title,
    this.latLng,
    this.locationName,
    this.taggedFriends,
    this.url,
    this.statusInfo,
    this.privacy,
  });
}
