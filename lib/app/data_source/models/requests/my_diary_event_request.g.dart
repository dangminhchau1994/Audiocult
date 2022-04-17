// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_diary_event_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyDiaryEventRequest _$MyDiaryEventRequestFromJson(Map<String, dynamic> json) =>
    MyDiaryEventRequest()
      ..title = json['title'] as String?
      ..view = $enumDecodeNullable(_$MyDiaryEventViewEnumMap, json['view'])
      ..startDate = json['start_date'] as String?
      ..endDate = json['end_date'] as String?
      ..pageNumber = json['page'] as int?
      ..limit = json['limit'] as int;

Map<String, dynamic> _$MyDiaryEventRequestToJson(
        MyDiaryEventRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'view': _$MyDiaryEventViewEnumMap[instance.view],
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'page': instance.pageNumber,
      'limit': instance.limit,
    };

const _$MyDiaryEventViewEnumMap = {
  MyDiaryEventView.all: null,
  MyDiaryEventView.attending: 'attending',
  MyDiaryEventView.mayAttend: 'may-attend',
  MyDiaryEventView.notAttending: 'not-attending',
};
