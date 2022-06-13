import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_response.g.dart';

enum NotificationType {
  visitorNew,
  commentStatus,
  commentPhoto,
  commentAlbum,
  commentEvent,
  video,
  commentSong,
  feedLike,
  none,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationResponse {
  String? date;
  List<Notification>? notifications;

  NotificationResponse({this.date, this.notifications});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Notification {
  String? notificationId;
  String? typeId;
  String? itemId;
  String? userId;
  String? ownerUserId;
  String? isSeen;
  String? isRead;
  String? timeStamp;
  String? itemUserId;
  String? userServerId;
  String? userName;
  String? fullName;
  String? gender;
  String? userImage;
  String? link;
  String? message;
  String? customIcon;

  Notification({
    this.notificationId,
    this.typeId,
    this.itemId,
    this.userId,
    this.ownerUserId,
    this.isSeen,
    this.isRead,
    this.timeStamp,
    this.itemUserId,
    this.userServerId,
    this.userName,
    this.fullName,
    this.gender,
    this.userImage,
    this.link,
    this.message,
    this.customIcon,
  });

  NotificationType getNotificationType() {
    switch (typeId) {
      case 'visitor_new':
        return NotificationType.visitorNew;
      case 'comment_music_song':
        return NotificationType.commentSong;
      case 'comment_event':
        return NotificationType.commentEvent;
      case 'comment_music_album':
        return NotificationType.commentAlbum;
      default:
        return NotificationType.none;
    }
  }

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}
