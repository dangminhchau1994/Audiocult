// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementResponse _$AnnouncementResponseFromJson(
        Map<String, dynamic> json) =>
    AnnouncementResponse(
      announcementId: json['announcement_id'] as String?,
      subjectVar: json['subject_var'] as String?,
      introVar: json['intro_var'] as String?,
      contentVar: json['content_var'] as String?,
      canBeClosed: json['can_be_closed'] as String?,
      showInDashboard: json['show_in_dashboard'] as String?,
      style: json['style'] as String?,
      isUrgent: json['is_urgent'] as String?,
      totalView: json['total_view'] as String?,
      buttonLink: json['button_link'] as String?,
      buttonText: json['button_text'] as String?,
      imagePath: json['image_path'] as String?,
      postedOn: json['posted_on'] as String?,
      iconImage: json['icon_image'],
    );

Map<String, dynamic> _$AnnouncementResponseToJson(
        AnnouncementResponse instance) =>
    <String, dynamic>{
      'announcement_id': instance.announcementId,
      'subject_var': instance.subjectVar,
      'intro_var': instance.introVar,
      'content_var': instance.contentVar,
      'can_be_closed': instance.canBeClosed,
      'show_in_dashboard': instance.showInDashboard,
      'style': instance.style,
      'is_urgent': instance.isUrgent,
      'total_view': instance.totalView,
      'button_link': instance.buttonLink,
      'button_text': instance.buttonText,
      'image_path': instance.imagePath,
      'posted_on': instance.postedOn,
      'icon_image': instance.iconImage,
    };
