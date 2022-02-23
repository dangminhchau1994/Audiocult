class BaseRes<T> {
  T? data;
  dynamic message;
  int? code;

  BaseRes({this.data, this.message, this.code = 0});

  factory BaseRes.fromJson(Map<String, dynamic> json) {
    return BaseRes(data: json['data'] as T, message: json['message'], code: json['code'] as int?);
  }

  S mapData<S>(Function(dynamic json) mapper) {
    return mapper.call(data) as S;
  }
}
