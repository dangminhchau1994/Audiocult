import 'dart:convert';
import 'dart:io';

import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:dio/dio.dart';

class CreateEventRequest {
  String? eventId;
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
  String? imageUrl;
  String? hostName;
  String? hostDescription;
  String? hostWebsite;
  String? hostFacebook;
  String? hostTwitter;
  int? privacy;
  int? privacyComment;

  CreateEventRequest({
    this.eventId,
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
    this.imageUrl,
    this.hostName,
    this.hostDescription,
    this.hostWebsite,
    this.hostFacebook,
    this.hostTwitter,
    this.privacy,
    this.privacyComment,
  });

  CreateEventRequest.initFromEventResponse({EventResponse? eventResponse}) {
    eventId = eventResponse?.eventId;
    categoryId = eventResponse?.categories?.first.last;
    title = eventResponse?.title;
    description = eventResponse?.description;
    location = eventResponse?.location;
    lat = eventResponse?.lat;
    lng = eventResponse?.lng;
    tags = eventResponse?.tags;
    imageUrl = eventResponse?.imagePath;

    final multiProfileOfArtists = eventResponse?.lineup?.artist
        ?.map((e) => ProfileData(
              userId: e.userId,
              userName: e.userName,
              fullName: e.fullName,
              userImage: e.userImage,
            ))
        .toList();
    artist = jsonEncode(multiProfileOfArtists);

    final multiProfileOfEntertainment = eventResponse?.lineup?.entertainment
        ?.map(
          (e) => ProfileData()
            ..userId = e.userId
            ..userName = e.userName
            ..fullName = e.fullName
            ..userImage = e.userImage,
        )
        .toList();

    entertainment = jsonEncode(multiProfileOfEntertainment);
    startDate = eventResponse?.startDateTime?.day.toString();
    endDate = eventResponse?.endDateTime?.day.toString();
    starMonth = eventResponse?.startDateTime?.month.toString();
    endMonth = eventResponse?.endDateTime?.month.toString();
    startYear = eventResponse?.startDateTime?.year.toString();
    endYear = eventResponse?.endDateTime?.year.toString();
    startHour = eventResponse?.startDateTime?.hour.toString();
    endHour = eventResponse?.endDateTime?.hour.toString();
    startMinute = eventResponse?.startDateTime?.minute.toString();
    endMinute = eventResponse?.endDateTime?.minute.toString();
    hostName = eventResponse?.hostName;
    hostDescription = eventResponse?.hostDescription;
    hostWebsite = eventResponse?.website;
    hostFacebook = eventResponse?.facebook;
    hostTwitter = eventResponse?.twitter;
    privacy = int.tryParse(eventResponse?.privacy ?? '');
    privacyComment = int.tryParse(eventResponse?.privacyComment ?? '');
  }

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};
    data['val[category]'] = categoryId;
    data['val[title]'] = title;
    data['val[description]'] = description;
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
    if (image != null) {
      data['image'] = await MultipartFile.fromFile(image!.path);
    }
    data['val[host_name]'] = hostName;
    data['val[host_description]'] = hostDescription;
    data['val[website]'] = hostWebsite;
    data['val[facebook]'] = hostFacebook;
    data['val[twitter]'] = hostTwitter;
    data['val[privacy]'] = privacy;
    data['val[privacy_comment]'] = privacyComment;

    return data;
  }

  List<ProfileData>? get artistList {
    if (artist?.isNotEmpty != true) return null;
    final decodedData = jsonDecode(artist!) as List<dynamic>?;
    return decodedData?.map((e) => ProfileData.fromJson(e as Map<String, dynamic>)).toList();
  }

  List<ProfileData>? get entertainmentList {
    if (entertainment?.isNotEmpty != true) return null;
    final decodedData = jsonDecode(entertainment!) as List<dynamic>?;
    return decodedData?.map((e) => ProfileData.fromJson(e as Map<String, dynamic>)).toList();
  }

  bool get isEditing {
    return eventId?.isNotEmpty == true;
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
