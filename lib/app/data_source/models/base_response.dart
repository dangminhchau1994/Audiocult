class BaseRes<T> {
  T? data;
  dynamic message;
  int? code;
  dynamic status;
  dynamic error;

  BaseRes({this.data, this.message, this.code = 0, this.status, this.error});

  factory BaseRes.fromJson(Map<String, dynamic> json) {
    return BaseRes(
      data: json['data'] as T ?? json['predictions'] as T,
      message: json['message'],
      code: json['code'] as int?,
      status: json['status'],
      error: json['error'],
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
