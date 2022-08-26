import 'package:audio_cult/app/data_source/models/responses/productlist/productlist.dart';
import 'package:audio_cult/app/data_source/models/responses/question_ticket/question_ticket.dart';
import 'package:dio/dio.dart';
import 'package:stripe_platform_interface/src/models/payment_methods.dart';

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

  Future<BaseRes?> addTicketToCart(List<Items> list, String eventId, String userName) async {
    final body = <String, dynamic>{};
    list.forEach((element) {
      body.addAll({'item_${element.id}': element.count});
    });
    print(body);
    final response = await _dioHelper.post(
      route: '/capi/$userName/$eventId/cart/add',
      requestBody: FormData.fromMap(body),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }

  Future<BaseRes?> clearTicketToCart(String eventId, String userName) async {
    final response = await _dioHelper.post(
      route: '/capi/$userName/$eventId/cart/clear',
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }

  Future<QuestionTicket> getListPaymentTickets(String eventId, String userName) async {
    final response = await _dioHelper.get(
        route: '/capi/$userName/$eventId/questions',
        responseBodyMapper: (jsonMapper) {
          return QuestionTicket.fromJson(jsonMapper as Map<String, dynamic>);
        });
    return response;
  }

  Future<BaseRes?> submitQuestions(Map<String, dynamic> dataStep1, String eventId, String username) async {
    final response = await _dioHelper.post(
      route: '/capi/$username/$eventId/questions',
      requestBody: FormData.fromMap(dataStep1),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }

  Future<BaseRes?> submitCardPayment(PaymentMethod paymentMethod, String eventId, String username) async {
    final response = await _dioHelper.post(
      route: '/capi/$username/$eventId/payment/stripe',
      requestBody: FormData.fromMap({
        'payment_method_id': paymentMethod.id,
        'stripe_card_brand': paymentMethod.card.brand,
        'stripe_card_last4': paymentMethod.card.last4
      }),
      responseBodyMapper: (jsonMapper) => BaseRes.fromJson(jsonMapper as Map<String, dynamic>),
    );
    return response;
  }
}
