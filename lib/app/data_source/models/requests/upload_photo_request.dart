import 'dart:io';

class UploadPhotoRequest {
  List<File>? images;
  int? eventId;
  String? description;
  String? latLng;
  String? locationName;
  String? userId;
  int? albumId;
  int? privacy;
  String? taggedFriends;

  UploadPhotoRequest({
    this.images,
    this.description,
    this.latLng,
    this.eventId,
    this.taggedFriends,
    this.locationName,
    this.userId,
    this.albumId,
    this.privacy,
  });
}
