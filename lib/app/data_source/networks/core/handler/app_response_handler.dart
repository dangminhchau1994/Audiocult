import 'package:dio/dio.dart';

import '../../exceptions/api_exception.dart';
import 'response_handler.dart';

class AppResponseHandler implements ResponseHandler {
  @override
  dynamic onResponse(Response response) {
    final dynamic responseData = response.data;
    if (!((response.statusCode! < 200) || (response.statusCode! >= 300))) {
      return responseData;
    } else {
      final message = responseData!['message'] as String;
      throw ApiException(message, statusCode: response.statusCode, errorCode: response.statusCode.toString());
    }
  }
}
