import 'dart:io';

class UploadPhotoRequest {
  List<File>? images;
  String? description;
  String? latLng;
  String? locationName;
  int? userId;
  int? albumId;
  int? privacy;
  String? taggedFriends;

  UploadPhotoRequest({
    this.images,
    this.description,
    this.latLng,
    this.taggedFriends,
    this.locationName,
    this.userId,
    this.albumId,
    this.privacy,
  });
}
