import '../../../base/index_walker.dart';
import 'profile_data.dart';

class RegisterResponse {
  String? status;
  ProfileData? data;
  String? message;
  String? error;

  RegisterResponse({this.status, this.data, this.message, this.error});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);

    status = iw['status'].get();
    data = iw['data'].get(rawBuilder: (values) => ProfileData.fromJson(values as Map<String, dynamic>));
    message = iw['message'].get();
    error = iw['error'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
