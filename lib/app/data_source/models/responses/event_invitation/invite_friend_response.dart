import 'package:freezed_annotation/freezed_annotation.dart';
part 'invite_friend_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InviteFriendResponse {
  User? emails;
  User? users;

  InviteFriendResponse({this.emails, this.users});

  factory InviteFriendResponse.fromJson(Map<String, dynamic> json) => _$InviteFriendResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  List<String>? sent;
  List<dynamic>? alreadyInvited;
  List<dynamic>? invalid;

  User({this.sent, this.alreadyInvited, this.invalid});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
