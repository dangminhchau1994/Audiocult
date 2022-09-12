import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/ticket_details/ticket_details.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

class MyTicketsOfEventBloc extends BaseBloc {
  final AppRepository _appRepo;

  final _allTicketsOfEventStreamController = StreamController<List<TicketDetails>>.broadcast();
  Stream<List<TicketDetails>> get allTicketsStream => _allTicketsOfEventStreamController.stream;

  MyTicketsOfEventBloc(this._appRepo);

  void getAllTicketsOfEvent(String? eventId) async {
    if (eventId?.isNotEmpty != true) return;
    showOverLayLoading();
    final result = await _appRepo.getAllMyTickets(eventId: eventId);
    hideOverlayLoading();
    result.fold(
      (l) {
        if (l?.isSuccess == true) {
          final tickets = asType<List<dynamic>>(l?.data)
              ?.map(
                (e) => TicketDetails.fromJson(e as Map<String, dynamic>),
              )
              .toList();
          _allTicketsOfEventStreamController.sink.add(tickets ?? []);
        }
      },
      _allTicketsOfEventStreamController.addError,
    );
  }
}
