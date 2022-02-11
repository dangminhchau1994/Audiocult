import 'package:dio/dio.dart';

import '../networks/core/dio_helper.dart';
import '../networks/core/handler/app_response_handler.dart';

class AppServiceProvider {
  late DioHelper _dioHelper;

  AppServiceProvider(Dio dio) {
    _dioHelper = DioHelper(dio, responseHandler: AppResponseHandler());
  }

  // Future<Authorize> login(LoginRequest request) async {
  //   var response = await _dioHelper.post(
  //       route: '/account/sessions',
  //       requestBody: request.toJson(),
  //       responseBodyMapper: (jsonMap) => BaseRes.fromJson(jsonMap));
  //   return Authorize.fromJson(response.data);
  // }

}
