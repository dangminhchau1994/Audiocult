import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_diary_event_request.g.dart';

@JsonSerializable()
class MyDiaryEventRequest {
  MyDiaryEventView? view;
  @JsonKey(name: 'date')
  String? dateTime; //Date Y-m-d 1982-01-01
  @JsonKey(name: 'page')
  int? pageNumber;
  int limit = 10;

  MyDiaryEventRequest();

  factory MyDiaryEventRequest.fromJson(Map<String, dynamic> json) => _$MyDiaryEventRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyDiaryEventRequestToJson(this);

  @override
  String toString() {
    return 'MyDiaryEventRequest: ${view?.iconPath} -- ${dateTime} -- $pageNumber --- $limit';
  }
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
        return context.l10n.t_attending;
      case MyDiaryEventView.mayAttend:
        return context.l10n.t_maybe_attending;
      case MyDiaryEventView.notAttending:
        return context.l10n.t_already_bought;
      case MyDiaryEventView.all:
        return context.l10n.t_all_events;
    }
  }
}
