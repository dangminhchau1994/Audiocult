import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommentResponse {
  String? isLiked;
  String? commentId;
  String? parentId;
  String? typeId;
  String? itemId;
  String? userId;
  String? ownerUserId;
  String? timeStamp;
  String? childTotal;
  String? totalLike;
  String? text;
  String? userName;
  String? fullName;
  String? userImage;
  LastIcon? lastIcon;

  CommentResponse({
    this.isLiked,
    this.commentId,
    this.parentId,
    this.typeId,
    this.itemId,
    this.userId,
    this.ownerUserId,
    this.timeStamp,
    this.childTotal,
    this.totalLike,
    this.text,
    this.userName,
    this.fullName,
    this.userImage,
    this.lastIcon,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) => _$CommentResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LastIcon {
  String? likeTypeId;
  String? imagePath;
  String? countIcon;

  LastIcon({
    this.likeTypeId,
    this.imagePath,
    this.countIcon,
  });

  factory LastIcon.fromJson(Map<String, dynamic> json) => _$LastIconFromJson(json);
}
