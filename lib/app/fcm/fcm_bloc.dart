import 'package:rxdart/rxdart.dart';

class FCMBloc {
  final _countBadgeSubject = PublishSubject<int>();
  final _showBadgeSubject = PublishSubject<int>();

  Stream<int> get countBadgeStream => _countBadgeSubject.stream;
  Stream<int> get showBadgeStream => _showBadgeSubject.stream;

  void showBadge(int showBadge) {
    _showBadgeSubject.sink.add(showBadge);
  }

  void countBadge(int count) async {
    _countBadgeSubject.sink.add(count);
  }
}
