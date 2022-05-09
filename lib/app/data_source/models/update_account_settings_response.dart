class UpdateAccountSettingsResponse {
  String? status;
  String? error;
  String? message;

  UpdateAccountSettingsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String;
    message = json['message'] as String;
    if (json['error'] != null) {
      error = json['error']['message'] as String;
    }
  }
}
