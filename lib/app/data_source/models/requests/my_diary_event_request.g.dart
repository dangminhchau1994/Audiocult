// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_diary_event_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyDiaryEventRequest _$MyDiaryEventRequestFromJson(Map<String, dynamic> json) =>
    MyDiaryEventRequest()
      ..view = $enumDecodeNullable(_$MyDiaryEventViewEnumMap, json['view'])
      ..dateTime = json['date'] as String?
      ..pageNumber = json['page'] as int?
      ..limit = json['limit'] as int;

Map<String, dynamic> _$MyDiaryEventRequestToJson(
        MyDiaryEventRequest instance) =>
    <String, dynamic>{
      'view': _$MyDiaryEventViewEnumMap[instance.view],
      'date': instance.dateTime,
      'page': instance.pageNumber,
      'limit': instance.limit,
    };

const _$MyDiaryEventViewEnumMap = {
  MyDiaryEventView.all: null,
  MyDiaryEventView.attending: 'attending',
  MyDiaryEventView.mayAttend: 'may-attend',
  MyDiaryEventView.notAttending: 'not-attending',
};
