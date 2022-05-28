import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_photo_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadPhotoResponse {
  bool? isLiked;
  String? userId;
  String? photoId;
  String? albumId;
  dynamic moduleId;
  String? groupId;
  String? privacy;
  String? privacyComment;
  String? title;
  String? timeStamp;
  String? isFeatured;
  String? isSponsor;
  dynamic categories;
  String? bookmarkUrl;
  String? photoUrl;

  UploadPhotoResponse({
    this.isLiked,
    this.userId,
    this.photoId,
    this.albumId,
    this.moduleId,
    this.groupId,
    this.privacy,
    this.privacyComment,
    this.title,
    this.timeStamp,
    this.isFeatured,
    this.isSponsor,
    this.categories,
    this.bookmarkUrl,
    this.photoUrl,
  });

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) => _$UploadPhotoResponseFromJson(json);
}
