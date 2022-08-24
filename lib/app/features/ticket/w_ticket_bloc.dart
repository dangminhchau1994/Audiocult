import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/productlist/productlist.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/subjects.dart';

class TicketBloc extends BaseBloc {
  final AppRepository _appRepository;

  TicketBloc(this._appRepository);

  final _getListTicketsSubject = PublishSubject<BlocState<TicketProductList>>();

  Stream<BlocState<TicketProductList>> get getListTicketsStream => _getListTicketsSubject.stream;

  void getListTicket(String eventId, String username) async {
    final result = await _appRepository.getListTicket(eventId, username);

    result.fold((data) {
      _getListTicketsSubject.sink.add(BlocState.success(data!));
    }, (e) {
      _getListTicketsSubject.sink.add(BlocState.error(e.toString()));
    });
  }
}
