class BaseRes<T> {
  T? data;
  dynamic message;
  int? code;
  dynamic status;
  dynamic error;
  bool? isSuccess;

  BaseRes({this.data, this.message, this.code = 0, this.status, this.error, this.isSuccess});

  factory BaseRes.fromJson(Map<String, dynamic> json) {
    return BaseRes(
      data: json['data'] as T ?? json['predictions'] as T,
      message: json['message'] ?? json['messages'],
      code: int.tryParse(json['code'].toString()) ?? 0,
      status: json['status'],
      error: json['error'],
      isSuccess: json['status'] == StatusString.success,
    );
  }

  S mapData<S>(Function(dynamic json) mapper) {
    return mapper.call(data) as S;
  }
}

class StatusString {
  static const String success = 'success';
  static const String failed = 'failed';
}
