
import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnnouncementResponse {
  String? announcementId;
  String? subjectVar;
  String? introVar;
  String? contentVar;
  String? canBeClosed;
  String? showInDashboard;
  String? style;
  String? isUrgent;
  String? totalView;
  String? buttonLink;
  String? buttonText;
  String? imagePath;
  String? postedOn;
  String? iconImage;

  AnnouncementResponse({
    this.announcementId,
    this.subjectVar,
    this.introVar,
    this.contentVar,
    this.canBeClosed,
    this.showInDashboard,
    this.style,
    this.isUrgent,
    this.totalView,
    this.buttonLink,
    this.buttonText,
    this.imagePath,
    this.postedOn,
    this.iconImage,
  });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) => _$AnnouncementResponseFromJson(json);
}
