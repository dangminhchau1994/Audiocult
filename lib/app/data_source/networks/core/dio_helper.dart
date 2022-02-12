// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../exceptions/api_exception.dart';
import '../exceptions/app_exception.dart';
import '../exceptions/bad_request_exception.dart';
import '../exceptions/forbidden_exception.dart';
import '../exceptions/no_internet_exception.dart';
import '../exceptions/server_exception.dart';
import '../exceptions/unauthorised_exception.dart';
import 'handler/response_handler.dart';

/// Http request type
enum RequestType { GET, POST, PUT, DELETE }

typedef ResponseBodyMapper<T> = T Function(dynamic jsonMap);

class DioHelper {
  final Dio _dio;
  final ResponseHandler? responseHandler;

  DioHelper(this._dio, {this.responseHandler});

  Map<String, dynamic> headersRequest() {
    return <String, dynamic>{};
  }

  Future<T> request<T>({
    required String route,
    required RequestType requestType,
    Map<String, dynamic>? requestParams,
    dynamic requestBody,
    CancelToken? cancelToken,
    bool? isAuthRequired = true,
    ResponseBodyMapper<T>? responseBodyMapper,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    /// check internet connectivity & return an internet error message
    // if (!kIsWeb && !await ConnectivityManager.isConnected()) {
    //   return _internetError<T>();
    // }
    return _safeFetch(() async {
      // ignore: parameter_assignments
      options = options ?? Options();
      if (options!.headers == null) {
        options!.headers = <String, dynamic>{};
      }
      switch (requestType) {

        /// http get request method
        case RequestType.GET:
          final response = await _dio.get<T>(
            route,
            queryParameters: requestParams,
            cancelToken: cancelToken,
            options: options,
            onReceiveProgress: onReceiveProgress,
          );
          return _processResponse(response, responseBodyMapper);

        /// http post request method
        case RequestType.POST:
          final response = await _dio.post<T>(
            route,
            data: requestBody,
            queryParameters: requestParams,
            cancelToken: cancelToken,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          return _processResponse(response, responseBodyMapper);

        /// http put request method
        case RequestType.PUT:
          final response = await _dio.put<T>(
            route,
            data: requestBody,
            queryParameters: requestParams,
            cancelToken: cancelToken,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          return _processResponse(response, responseBodyMapper);

        /// http delete request method
        case RequestType.DELETE:
          final response = await _dio.delete<T>(
            route,
            data: requestBody,
            queryParameters: requestParams,
            cancelToken: cancelToken,
            options: options,
          );
          return _processResponse(response, responseBodyMapper);

        /// throw an exception when no http request method is passed
        // ignore: no_default_cases
        default:
          throw Exception('No request type passed');
      }
    });
  }

  Future<T> get<T>({
    required String route,
    Map<String, dynamic>? requestParams,
    dynamic requestBody,
    CancelToken? cancelToken,
    bool? isAuthRequired,
    ResponseBodyMapper<T>? responseBodyMapper,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      route: route,
      requestType: RequestType.GET,
      requestParams: requestParams,
      requestBody: requestBody,
      cancelToken: cancelToken,
      isAuthRequired: isAuthRequired,
      responseBodyMapper: responseBodyMapper,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<T> post<T>({
    required String route,
    Map<String, dynamic>? requestParams,
    dynamic requestBody,
    CancelToken? cancelToken,
    bool? isAuthRequired,
    ResponseBodyMapper<T>? responseBodyMapper,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      route: route,
      requestType: RequestType.POST,
      requestParams: requestParams,
      requestBody: requestBody,
      cancelToken: cancelToken,
      isAuthRequired: isAuthRequired,
      responseBodyMapper: responseBodyMapper,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<T> put<T>({
    required String route,
    Map<String, dynamic>? requestParams,
    dynamic requestBody,
    CancelToken? cancelToken,
    bool? isAuthRequired,
    ResponseBodyMapper<T>? responseBodyMapper,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      route: route,
      requestType: RequestType.PUT,
      requestParams: requestParams,
      requestBody: requestBody,
      cancelToken: cancelToken,
      isAuthRequired: isAuthRequired,
      responseBodyMapper: responseBodyMapper,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<T> delete<T>({
    required String route,
    Map<String, dynamic>? requestParams,
    dynamic requestBody,
    CancelToken? cancelToken,
    bool? isAuthRequired,
    ResponseBodyMapper<T>? responseBodyMapper,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request(
      route: route,
      requestType: RequestType.DELETE,
      requestParams: requestParams,
      requestBody: requestBody,
      cancelToken: cancelToken,
      isAuthRequired: isAuthRequired,
      responseBodyMapper: responseBodyMapper,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  T _processResponse<T>(Response response, ResponseBodyMapper<T>? responseBodySerializer) {
    dynamic responseData;
    if (response.data is Map || response.data is List || response.data.toString().isEmpty) {
      responseData = response.data;
    } else if (response.data == null || response.data == '') {
      responseData = '';
    } else {
      responseData = convert.jsonDecode(response.toString());
    }
    response.data = responseData;
    if (responseHandler != null) {
      final dynamic result = responseHandler!.onResponse(response);
      if (responseBodySerializer != null) {
        return responseBodySerializer(result);
      }
      return result as T;
    } else {
      if (responseBodySerializer != null) {
        return responseBodySerializer(response.data);
      }
      return response.data as T;
    }
  }

  /// Wrap fetch (get/post) request with try-catch
  /// & error handling
  Future<T> _safeFetch<T>(Future<T> Function() tryFetch) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw NoInternetException();
    }
    try {
      final response = await tryFetch();
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } on DioError catch (e) {
      _handleErrorDio(e);
    } catch (e) {
      rethrow;
    }
    throw AppException('Lỗi không xác định, vui lòng thử lại');
  }

  Exception _handleErrorDio(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        throw TimeoutException('Connection timeout');
      case DioErrorType.receiveTimeout:
        throw TimeoutException('Receive timeout');
      case DioErrorType.sendTimeout:
        throw TimeoutException('Send data timeout');
      case DioErrorType.response:
        throw _responseError(e.response!);
      // ignore: no_default_cases
      default:
        throw Exception(e.message);
    }
  }

  Exception _responseError(Response response) {
    try {
      dynamic message = 'Something wrong, please try again';
      // ignore: prefer_typing_uninitialized_variables
      var errorCode = '';
      if (response.data is Map) {
        message = response.data['message'] ?? response.data['error'];
        errorCode = response.data['errorCode'] as String;
      }
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(response.statusCode!, message);
        case 401:
          throw UnauthorisedException(response.statusCode!, message, errorCode);
        case 403:
          throw ForbiddenException(response.statusCode!, message);
        case 500:
          throw ServerException(response.statusCode!, response.statusMessage, '500');
        default:
          throw ApiException(message, statusCode: response.statusCode, errorCode: errorCode);
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
