import 'package:audio_cult/app/base/index_walker.dart';

class NotificationOption {
  String? key;
  String? phrase;
  int? defaultValue;
  bool? isChecked;

  NotificationOption();

  NotificationOption.fromJson(this.key, Map<String, dynamic> json) {
    final iw = IW(json);
    phrase = iw['phrase'].get();
    defaultValue = iw['default'].get();
    isChecked = iw['is_checked'].get();
  }
}
