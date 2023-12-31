// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      rsvpId: json['rsvp_id'] as String?,
      eventId: json['event_id'] as String?,
      viewId: json['view_id'] as String?,
      isFeatured: json['is_featured'] as String?,
      isSponsor: json['is_sponsor'] as String?,
      privacy: json['privacy'] as String?,
      privacyComment: json['privacy_comment'] as String?,
      moduleId: json['module_id'] as String?,
      itemId: json['item_id'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      location: json['location'] as String?,
      countryIso: json['country_iso'] as String?,
      countryChildId: json['country_child_id'] as String?,
      postalCode: json['postal_code'] as String?,
      lastIcon: json['last_icon'] == null
          ? null
          : LastIcon.fromJson(json['last_icon'] as Map<String, dynamic>),
      city: json['city'] as String?,
      timeStamp: json['time_stamp'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      startTimeString: json['start_time_string'] as String?,
      endTimeString: json['end_time_string'] as String?,
      timeStampString: json['time_stamp_string'] as String?,
      imagePath: json['image_path'] as String?,
      totalComment: json['total_comment'] as String?,
      totalLike: json['total_like'] as String?,
      gmap: json['gmap'] as String?,
      address: json['address'] as String?,
      tags: json['tags'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      description: json['description'] as String?,
      eventDate: json['event_date'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      lineup: json['lineup'] == null
          ? null
          : Lineup.fromJson(json['lineup'] as Map<String, dynamic>),
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
      cultixUri: json['cultix_uri'] as String?,
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      'rsvp_id': instance.rsvpId,
      'event_id': instance.eventId,
      'view_id': instance.viewId,
      'is_featured': instance.isFeatured,
      'is_sponsor': instance.isSponsor,
      'privacy': instance.privacy,
      'privacy_comment': instance.privacyComment,
      'module_id': instance.moduleId,
      'item_id': instance.itemId,
      'user_id': instance.userId,
      'title': instance.title,
      'location': instance.location,
      'country_iso': instance.countryIso,
      'country_child_id': instance.countryChildId,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'time_stamp': instance.timeStamp,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'start_time_string': instance.startTimeString,
      'end_time_string': instance.endTimeString,
      'time_stamp_string': instance.timeStampString,
      'image_path': instance.imagePath,
      'total_comment': instance.totalComment,
      'total_like': instance.totalLike,
      'gmap': instance.gmap,
      'address': instance.address,
      'lat': instance.lat,
      'tags': instance.tags,
      'lng': instance.lng,
      'description': instance.description,
      'event_date': instance.eventDate,
      'categories': instance.categories,
      'lineup': instance.lineup,
      'last_icon': instance.lastIcon,
      'tickets': instance.tickets,
      'cultix_uri': instance.cultixUri,
    };

LastIcon _$LastIconFromJson(Map<String, dynamic> json) => LastIcon(
      likeTypeId: json['like_type_id'] as String?,
      imagePath: json['image_path'] as String?,
      countIcon: json['count_icon'] as String?,
    );

Map<String, dynamic> _$LastIconToJson(LastIcon instance) => <String, dynamic>{
      'like_type_id': instance.likeTypeId,
      'image_path': instance.imagePath,
      'count_icon': instance.countIcon,
    };

Lineup _$LineupFromJson(Map<String, dynamic> json) => Lineup(
      artist: (json['artist'] as List<dynamic>?)
          ?.map((e) => ArtistUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LineupToJson(Lineup instance) => <String, dynamic>{
      'artist': instance.artist,
    };
