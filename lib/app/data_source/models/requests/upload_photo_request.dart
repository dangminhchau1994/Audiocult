import 'dart:io';

class UploadPhotoRequest {
  List<File>? images;
  String? description;
  int? userId;
  int? albumId;
  int? privacy;

  UploadPhotoRequest({
    this.images,
    this.description,
    this.userId,
    this.albumId,
    this.privacy,
  });
}
