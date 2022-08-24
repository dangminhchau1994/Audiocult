import 'package:audio_cult/app/data_source/models/responses/productlist/productlist.dart';
import 'package:dio/dio.dart';

import '../models/base_response.dart';
import '../networks/core/dio_helper.dart';

class PaymentServiceProvider {
  late DioHelper _dioHelper;

  PaymentServiceProvider(Dio dio) {
    _dioHelper = DioHelper(dio);
  }

  Future<TicketProductList> getListTicket(String eventId, String userName) async {
    final response = await _dioHelper.get(
        route: '/$userName/$eventId/widget/product_list',
        responseBodyMapper: (jsonMapper) {
          return TicketProductList.fromJson(jsonMapper as Map<String, dynamic>);
        });
    return response;
  }
}
