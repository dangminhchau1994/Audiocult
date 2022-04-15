import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';

class EventViewEntity {
  late MyDiaryEventView view;

  bool isSelected = false;

  EventViewEntity();

  @override
  bool operator ==(eventView) => eventView is EventViewEntity && view == eventView.view;
}
