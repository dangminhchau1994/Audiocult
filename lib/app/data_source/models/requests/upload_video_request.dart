import 'dart:io';

class UploadVideoRequest {
  File? video;
  String? title;
  String? url;
  String? statusInfo;

  UploadVideoRequest({
    this.video,
    this.title,
    this.url,
    this.statusInfo,
  });
}
