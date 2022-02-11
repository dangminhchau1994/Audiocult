import 'package:dio/dio.dart';

// ignore: one_member_abstracts
abstract class ResponseHandler {
  dynamic onResponse(Response response);
}
