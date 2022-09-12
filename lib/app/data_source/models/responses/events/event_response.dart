import 'package:audio_cult/app/data_source/models/responses/song_detail/song_detail_response.dart';
import 'package:audio_cult/app/data_source/models/responses/ticket/ticket.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'event_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EventResponse {
  String? rsvpId;
  String? eventId;
  String? viewId;
  String? isFeatured;
  String? isSponsor;
  String? privacy;
  String? privacyComment;
  String? moduleId;
  String? itemId;
  String? userId;
  String? title;
  String? location;
  String? countryIso;
  String? countryChildId;
  String? postalCode;
  String? city;
  String? timeStamp;
  String? startTime;
  String? endTime;
  String? startTimeString;
  String? endTimeString;
  String? timeStampString;
  String? imagePath;
  String? totalComment;
  String? totalLike;
  String? gmap;
  String? address;
  String? lat;
  String? tags;
  String? lng;
  String? description;
  String? eventDate;
  List<List<String>>? categories;
  Lineup? lineup;
  LastIcon? lastIcon;
  List<Ticket>? tickets;
  String? cultixUri;

  EventResponse(
      {this.rsvpId,
      this.eventId,
      this.viewId,
      this.isFeatured,
      this.isSponsor,
      this.privacy,
      this.privacyComment,
      this.moduleId,
      this.itemId,
      this.userId,
      this.title,
      this.location,
      this.countryIso,
      this.countryChildId,
      this.postalCode,
      this.lastIcon,
      this.city,
      this.timeStamp,
      this.startTime,
      this.endTime,
      this.startTimeString,
      this.endTimeString,
      this.timeStampString,
      this.imagePath,
      this.totalComment,
      this.totalLike,
      this.gmap,
      this.address,
      this.tags,
      this.lat,
      this.lng,
      this.description,
      this.eventDate,
      this.categories,
      this.lineup,
      this.tickets,
      this.cultixUri});

  factory EventResponse.fromJson(Map<String, dynamic> json) => _$EventResponseFromJson(json);

  String getFormatedDateTime() {
    if (startTime == null) return '';
    final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(startTime!) * 1000);
    final dateTimeFromStr = DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
    return dateTimeFromStr;
  }

  DateTime? get startDateTime {
    return DateTime.tryParse(startTimeString ?? '');
  }

  DateTime? get endDateTime {
    return DateTime.tryParse(endTimeString ?? '');
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LastIcon {
  String? likeTypeId;
  String? imagePath;
  String? countIcon;

  LastIcon({this.likeTypeId, this.imagePath, this.countIcon});

  factory LastIcon.fromJson(Map<String, dynamic> json) => _$LastIconFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Lineup {
  List<ArtistUser>? artist;

  Lineup({this.artist});

  factory Lineup.fromJson(Map<String, dynamic> json) => _$LineupFromJson(json);
}
