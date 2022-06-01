import 'dart:io';

import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/w_components/dialogs/app_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../utils/route/app_route.dart';
import '../../local/pref_provider.dart';
import '../../services/navigation_service.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final PrefProvider _prefProvider;
  // ignore: unused_field
  final Dio _dio;
  final NavigationService _navigationService;

  AuthInterceptor(this._dio, this._prefProvider, this._navigationService);

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
    if (err.response != null && err.response?.statusCode == 401) {
      AppDialog.showYesNoDialog(navigatorKey.currentContext!, message: 'Token expired', onNoPressed: () async {
        await _prefProvider.clearAuthentication();
        await _prefProvider.clearUserId();
        locator.get<AppRepository>().clearProfile();
        exit(0);
      }, onYesPressed: () async {
        await _prefProvider.clearAuthentication();
        await _prefProvider.clearUserId();
        locator.get<AppRepository>().clearProfile();
        await Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, AppRoute.routeLogin, (route) => false);
      });
    } else {
      handler.next(err);
    }
  }

  bool isAuthenticationAlready(RequestOptions options) {
    return options.headers.containsKey('Authorization');
  }
}
