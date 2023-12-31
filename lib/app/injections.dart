// ignore_for_file: avoid_redundant_argument_values

import 'package:audio_cult/app/data_source/services/payment_service_provider.dart';
import 'package:audio_cult/app/data_source/services/language_provider.dart';
import 'package:audio_cult/app/services/media_handler_service.dart';
import 'package:audio_cult/app/services/media_service.dart';
import 'package:audio_cult/app/services/permission_handler_service.dart';
import 'package:audio_cult/app/services/permisssion_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_source/local/pref_provider.dart';
import 'data_source/networks/core/dio_flutter_transformer.dart';
import 'data_source/networks/interceptors/app_interceptor.dart';
import 'data_source/networks/interceptors/auth_interceptor.dart';
import 'data_source/networks/interceptors/pretty_dio_logger.dart';
import 'data_source/repositories/app_repository.dart';
import 'data_source/services/app_service_provider.dart';
import 'data_source/services/assets_local_provider.dart';
import 'data_source/services/hive_service_provider.dart';
import 'data_source/services/navigation_service.dart';
import 'data_source/services/place_service_provider.dart';
import 'utils/flavor/flavor.dart';

GetIt locator = GetIt.instance;

Future<void> initDependency() async {
  final _sharePreference = await SharedPreferences.getInstance();

  locator.registerLazySingleton(() {
    return PrefProvider(_sharePreference);
  });
  locator.registerSingleton<NavigationService>(NavigationService());

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
        locator.get(),
      ),
    );
    dio.interceptors.add(AppInterceptor(locator.get()));
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(responseBody: false, requestHeader: false, responseHeader: false, requestBody: true),
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

  locator.registerLazySingleton<PaymentServiceProvider>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.ticketUrl!);
    return PaymentServiceProvider(dio);
  });

  locator.registerSingleton<PermissionService>(PermissionHandlerPermissionService());

  locator.registerSingleton<MediaServiceInterface>(MediaServiceHandler());

  locator.registerLazySingleton(
    () => AppRepository(
        appServiceProvider: locator.get(),
        placeServiceProvider: locator.get(),
        hiveServiceProvider: locator.get(),
        assetsLocalServiceProvider: locator.get(),
        prefProvider: locator.get(),
        paymentServiceProvider: locator.get()),
  );
  locator.registerLazySingleton(HiveServiceProvider.new);
  locator.registerLazySingleton(AssetsLocalServiceProvider.new);
  locator.registerLazySingleton(
    () => LanguageProvider(
      assetProvider: locator.get<AssetsLocalServiceProvider>(),
      appServiceProvider: locator.get<AppServiceProvider>(),
      prefProvider: locator.get<PrefProvider>(),
    ),
  );
}
