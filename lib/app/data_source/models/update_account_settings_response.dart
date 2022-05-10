import 'package:audio_cult/app/base/index_walker.dart';

class UpdateAccountSettingsResponse {
  String? status;
  String? error;
  String? message;

  UpdateAccountSettingsResponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    status = iw['status'].get();
    message = iw['message'].get();
    if (json['error'] != null) {
      error = json['error']['message'] as String;
    }
  }
}
