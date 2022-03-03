// ignore_for_file: avoid_redundant_argument_values

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_source/local/pref_provider.dart';
import 'data_source/networks/core/dio_flutter_transformer.dart';
import 'data_source/networks/interceptors/app_interceptor.dart';
import 'data_source/networks/interceptors/auth_interceptor.dart';
import 'data_source/networks/interceptors/pretty_dio_logger.dart';
import 'data_source/repositories/app_repository.dart';
import 'data_source/services/app_service_provider.dart';
import 'data_source/services/hive_service_provider.dart';
import 'data_source/services/place_service_provider.dart';
import 'utils/flavor/flavor.dart';

GetIt locator = GetIt.instance;

Future<void> initDependency() async {
  final _sharePreference = await SharedPreferences.getInstance();

  locator.registerLazySingleton(() {
    return PrefProvider(_sharePreference);
  });

  Dio _createDio(String baseUrl) {
    const _connectTimeout = 30000;
    const _receiveTimeout = 30000;
    const _sendTimeout = 30000;
    final options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      followRedirects: false,
      baseUrl: baseUrl,
    );
    final dio = Dio(options)..transformer = FlutterTransformer();
    dio.interceptors.add(
      AuthInterceptor(
        dio,
        locator.get(),
      ),
    );
    dio.interceptors.add(AppInterceptor(locator.get()));
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(responseBody: false, requestHeader: true, responseHeader: false, requestBody: true),
      );
    }
    return dio;
  }

  locator.registerLazySingleton<AppServiceProvider>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return AppServiceProvider(dio);
  });
  locator.registerLazySingleton<PlaceServiceProvider>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.placeUrl!);
    return PlaceServiceProvider(dio);
  });

  locator.registerLazySingleton(
    () => AppRepository(
      appServiceProvider: locator.get(),
      placeServiceProvider: locator.get(),
      hiveServiceProvider: locator.get(),
    ),
  );
  locator.registerLazySingleton(HiveServiceProvider.new);
}
