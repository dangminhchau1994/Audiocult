import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/question_ticket/question_ticket.dart';
import 'package:audio_cult/app/data_source/networks/exceptions/app_exception.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:stripe_platform_interface/src/models/payment_methods.dart';

import '../../../data_source/models/responses/payment_stripe.dart';

class PaymentTicketsBloc extends BaseBloc {
  final AppRepository _appRepository;

  PaymentTicketsBloc(this._appRepository);

  final _getListPaymentSubject = PublishSubject<BlocState<QuestionTicket>>();

  Stream<BlocState<QuestionTicket>> get getListPaymentStream => _getListPaymentSubject.stream;

  void getListPaymentTickets(String eventId, String username) async {
    final result = await _appRepository.getListPaymentTickets(eventId, username);

    result.fold((data) {
      _getListPaymentSubject.sink.add(BlocState.success(data!));
    }, (e) {
      _getListPaymentSubject.sink.add(BlocState.error(e.toString()));
    });
  }

  Future<bool> submitStep1(Map<String, dynamic> dataStep1, String eventId, String username) async {
    showOverLayLoading();
    final result = await _appRepository.submitQuestions(dataStep1, eventId, username);
    hideOverlayLoading();
    return result.fold((data) {
      return true;
    }, (e) {
      showError(e);
      return false;
    });
  }

  Future<bool> submitStep2(PaymentMethod paymentMethod, String eventId, String username) async {
    showOverLayLoading();
    final result = await _appRepository.submitCardPayment(paymentMethod, eventId, username);
    hideOverlayLoading();
    return result.fold((data) {
      return true;
    }, (e) {
      showError(e);
      return false;
    });
  }

  Future<bool> confirmPayment(String eventId, String username) async {
    showOverLayLoading();
    final result = await _appRepository.confirmPayment(eventId, username);
    hideOverlayLoading();
    return result.fold((data) {
      if (data!.isSuccess!) {
        return true;
      } else {
        showError(AppException(data.message));

        return false;
      }
    }, (e) {
      showError(e);
      return false;
    });
  }

  Future<PaymentStripe?> getStripeAccount(String? username, String? eventId) async {
    showOverLayLoading();
    final result = await _appRepository.getStripeAccount(username, eventId);
    hideOverlayLoading();
    return result.fold((data) {
      return data;
    }, (e) {
      showError(e);
      return null;
    });
  }
}
