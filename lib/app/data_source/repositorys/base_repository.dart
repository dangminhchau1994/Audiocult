import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../networks/exceptions/app_exception.dart';

class BaseRepository {
  Future<Either<T, Exception>> safeCall<T>(Future<T> Function() tryFetch) async {
    try {
      final result = await tryFetch();
      return left(result);
    } on DioError catch (e, stacktrace) {
      // ignore: avoid_print
      print('DioErrorException: $e');
      // ignore: avoid_print
      print('DioErrorStacktrace: $stacktrace');
      if (e.message.contains('SocketException')) {
        return right(AppException('Disconnect from internet! Please Try again!'));
      }
      return right(e);
    } catch (e, stacktrace) {
      // ignore: avoid_print
      print('Exception: $e');
      // ignore: avoid_print
      print('Stacktrace: $stacktrace');
      if (e is SocketException) {
        return right(AppException('Disconnect from internet! Please Try again!'));
      }
      return right(AppException(e.toString()));
    }
  }
}
