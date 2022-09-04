// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_friend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteFriendResponse _$InviteFriendResponseFromJson(
        Map<String, dynamic> json) =>
    InviteFriendResponse(
      emails: json['emails'] == null
          ? null
          : User.fromJson(json['emails'] as Map<String, dynamic>),
      users: json['users'] == null
          ? null
          : User.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InviteFriendResponseToJson(
        InviteFriendResponse instance) =>
    <String, dynamic>{
      'emails': instance.emails,
      'users': instance.users,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      sent: (json['sent'] as List<dynamic>?)?.map((e) => e as String).toList(),
      alreadyInvited: json['already_invited'] as List<dynamic>?,
      invalid: json['invalid'] as List<dynamic>?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'sent': instance.sent,
      'already_invited': instance.alreadyInvited,
      'invalid': instance.invalid,
    };
