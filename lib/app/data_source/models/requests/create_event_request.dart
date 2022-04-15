import 'dart:io';

class CreateEventRequest {
  String? categoryId;
  String? title;
  String? description;
  String? location;
  String? lat;
  String? lng;
  String? attachment;
  String? tags;
  String? artist;
  String? entertainment;
  String? startDate;
  String? endDate;
  String? starMonth;
  String? endMonth;
  String? startYear;
  String? endYear;
  String? startHour;
  String? endHour;
  String? startMinute;
  String? endMinute;
  File? image;
  String? hostName;
  String? hostDescription;
  String? hostWebsite;
  String? hostFacebook;
  String? hostTwitter;
  int? privacy;
  int? privacyComment;

  CreateEventRequest({
    this.categoryId,
    this.title,
    this.description,
    this.location,
    this.lat,
    this.lng,
    this.attachment,
    this.tags,
    this.artist,
    this.entertainment,
    this.startDate,
    this.endDate,
    this.starMonth,
    this.endMonth,
    this.startYear,
    this.endYear,
    this.startHour,
    this.endHour,
    this.startMinute,
    this.endMinute,
    this.image,
    this.hostName,
    this.hostDescription,
    this.hostWebsite,
    this.hostFacebook,
    this.hostTwitter,
    this.privacy,
    this.privacyComment,
  });
}

class UserId {
  final String? id;

  UserId({this.id});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = id;
    return data;
  }
}
