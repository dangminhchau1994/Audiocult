import 'package:dio/dio.dart';

import '../../local/pref_provider.dart';

class AppInterceptor extends Interceptor {
  final PrefProvider prefProvider;

  AppInterceptor(this.prefProvider);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var _currentLocale = 'vi';
    if (_currentLocale == 'vi') {
      _currentLocale = 'vn';
    }
    options.headers['Accept-Language'] = _currentLocale;
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
