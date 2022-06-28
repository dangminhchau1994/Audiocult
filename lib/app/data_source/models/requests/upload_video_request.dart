import 'dart:io';

class UploadVideoRequest {
  File? video;
  String? title;
  String? url;
  String? statusInfo;
  String? latLng;
  String? locationName;

  UploadVideoRequest({
    this.video,
    this.title,
    this.latLng,
    this.locationName,
    this.url,
    this.statusInfo,
  });
}
