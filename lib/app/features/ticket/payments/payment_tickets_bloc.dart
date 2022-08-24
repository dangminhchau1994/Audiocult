import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/question_ticket/question_ticket.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/subjects.dart';

class PaymentTicketsBloc extends BaseBloc {
  final AppRepository _appRepository;

  PaymentTicketsBloc(this._appRepository);

  final _getListPaymentSubject = PublishSubject<BlocState<QuestionTicket>>();

  Stream<BlocState<QuestionTicket>> get getListPaymentStream => _getListPaymentSubject.stream;

  void getListPaymentTickets(String eventId, String username) async {
    final result = await _appRepository.getListPaymentTickets(eventId, username);

    result.fold((data) {
      data!.itemQuestions!.forEach(
        (element) {
          print(element.id);
        },
      );
      // _getListPaymentSubject.sink.add(BlocState.success(data!));
    }, (e) {
      _getListPaymentSubject.sink.add(BlocState.error(e.toString()));
    });
  }
}
