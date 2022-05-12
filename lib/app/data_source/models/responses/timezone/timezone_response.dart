import 'package:audio_cult/app/base/index_walker.dart';

class TimeZoneReponse {
  String? status;
  List<TimeZone>? timezones;
  String? message;

  TimeZoneReponse.fromJson(Map<String, dynamic> json) {
    var iw = IW(json);
    status = iw['status'].get();
    message = iw['message'].get();

    final dataJson = json['data'] as Map<String, dynamic>;
    iw = IW(dataJson);
    timezones = dataJson.keys.map((e) {
      return TimeZone()
        ..key = e
        ..value = iw[e].get();
    }).toList();
  }
}

class TimeZone {
  String? key;
  String? value;
}
