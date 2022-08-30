import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_diary_event_request.g.dart';

@JsonSerializable()
class MyDiaryEventRequest {
  String? title;
  MyDiaryEventView? view;
  @JsonKey(name: 'start_date')
  String? startDate; //Date Y-m-d 1982-01-01
  @JsonKey(name: 'end_date')
  String? endDate; //Date Y-m-d 1982-01-01
  @JsonKey(name: 'page')
  int? pageNumber;
  int limit = 10;

  MyDiaryEventRequest();

  factory MyDiaryEventRequest.fromJson(Map<String, dynamic> json) => _$MyDiaryEventRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyDiaryEventRequestToJson(this);
}

enum MyDiaryEventView {
  @JsonValue(null)
  all,
  @JsonValue('attending')
  attending,
  @JsonValue('may-attend')
  mayAttend,
  @JsonValue('not-attending')
  notAttending,
}

extension MyDiaryEventViewExension on MyDiaryEventView {
  String get iconPath {
    switch (this) {
      case MyDiaryEventView.attending:
        return AppAssets.icAttending;
      case MyDiaryEventView.mayAttend:
        return AppAssets.icMaybeAttending;
      case MyDiaryEventView.notAttending:
        return AppAssets.icAlreadyBought;
      case MyDiaryEventView.all:
        return AppAssets.icAllEvents;
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case MyDiaryEventView.attending:
        return context.localize.t_attending;
      case MyDiaryEventView.mayAttend:
        return context.localize.t_maybe_attending;
      case MyDiaryEventView.notAttending:
        return context.localize.t_already_bought;
      case MyDiaryEventView.all:
        return context.localize.t_all_events;
    }
  }
}
