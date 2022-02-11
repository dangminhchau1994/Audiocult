import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../local/pref_provider.dart';

class AuthInterceptor extends Interceptor {
  final PrefProvider _prefProvider;
  final Dio _dio;

  AuthInterceptor(this._dio, this._prefProvider);

  @override
  // ignore: avoid_void_async
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!isAuthenticationAlready(options)) {
      final accessToken = _prefProvider.accessToken;
      if (accessToken != null && accessToken.isNotEmpty) {
        // ignore: avoid_print
        debugPrint(accessToken);
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  // ignore: avoid_void_async
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }

  bool isAuthenticationAlready(RequestOptions options) {
    return options.headers.containsKey('Authorization');
  }
}
