import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_invitation_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EventInvitationResponse {
  String? userId;
  String? profilePageId;
  String? userServerId;
  String? userName;
  String? fullName;
  String? gender;
  String? userImage;
  String? isInvisible;
  String? userGroupId;
  String? languageId;
  String? lastActivity;
  String? email;
  dynamic birthday;
  bool? isChecked;
  String? countryIso;
  dynamic isActive;

  EventInvitationResponse({
    this.userId,
    this.profilePageId,
    this.userServerId,
    this.userName,
    this.fullName,
    this.gender,
    this.isChecked = false,
    this.userImage,
    this.isInvisible,
    this.email,
    this.userGroupId,
    this.languageId,
    this.lastActivity,
    this.birthday,
    this.countryIso,
    this.isActive,
  });

  factory EventInvitationResponse.fromJson(Map<String, dynamic> json) => _$EventInvitationResponseFromJson(json);
}
