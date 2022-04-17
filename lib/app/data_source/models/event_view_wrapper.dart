import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';

class EventViewWrapper {
  late MyDiaryEventView view;

  bool isSelected = false;

  EventViewWrapper();

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, hash_and_equals
  bool operator ==(eventView) => eventView is EventViewWrapper && view == eventView.view;
}
