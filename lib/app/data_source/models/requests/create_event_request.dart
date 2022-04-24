import 'dart:io';

import 'package:dio/dio.dart';

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

  Future<Map<String, dynamic>> toJson() async {
    var imageFile;

    if (image != null) {
      imageFile = await MultipartFile.fromFile(image?.path ?? '');
    }

    final data = <String, dynamic>{};
    data['val[category]'] = categoryId;
    data['val[title]'] = title;
    data['val[location]'] = location;
    data['val[lat]'] = lat;
    data['val[lng]'] = lng;
    data['val[attachment]'] = attachment;
    data['val[tags]'] = tags;
    data['val[line_up][artist]'] = artist;
    data['val[line_up][entertainment]'] = entertainment;
    data['val[start_day]'] = startDate;
    data['val[start_month]'] = starMonth;
    data['val[start_year]'] = startYear;
    data['val[start_hour]'] = startHour;
    data['val[start_minute]'] = startMinute;
    data['val[end_day]'] = endDate;
    data['val[end_month]'] = endMonth;
    data['val[end_year]'] = endYear;
    data['val[end_hour]'] = endHour;
    data['val[end_minute]'] = endMinute;
    data['image'] = imageFile;
    data['val[host_name]'] = hostName;
    data['val[host_description]'] = hostDescription;
    data['val[website]'] = hostWebsite;
    data['val[facebook]'] = hostFacebook;
    data['val[twitter]'] = hostTwitter;
    data['val[privacy]'] = privacy;
    data['val[privacy_comment]'] = privacyComment;

    return data;
  }
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
