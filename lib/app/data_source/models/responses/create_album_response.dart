import '../../../base/index_walker.dart';

class CreateAlbumResponse {
  String? status;
  String? data;
  String? message;
  String? error;

  CreateAlbumResponse({this.status, this.data, this.message, this.error});

  CreateAlbumResponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);

    status = iw['status'].get();
    data = iw['data'].get();
    message = iw['message'].get();
    error = iw['error'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
