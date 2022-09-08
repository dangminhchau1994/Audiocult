import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:flutter/material.dart';

class MyTicketsBloc extends BaseBloc {
  final AppRepository _appRepo;
  MyTicketsTimeFilter? _currentFilter;
  MyTicketsTimeFilter? get currentFilter => _currentFilter;

  final _filterStreamController = StreamController<MyTicketsTimeFilter>.broadcast();
  Stream<MyTicketsTimeFilter> get filterChangeStream => _filterStreamController.stream;

  final _ticketsStreamController = StreamController<List<EventResponse>>.broadcast();
  Stream<List<EventResponse>> get ticketsStream => _ticketsStreamController.stream;

  late List<MyTicketsTimeFilter> filters;

  MyTicketsBloc(this._appRepo);

  void initData(BuildContext context) {
    var index = 0;
    filters = GlobalConstants.getWhenList(context)
        .map(
          (e) => MyTicketsTimeFilter(
            index: index++,
            title: e.keys.first,
            value: e.values.first,
          ),
        )
        .toList();
    _currentFilter = filters.first;
    getAllMyTickets();
  }

  void filterOnChange(MyTicketsTimeFilter? newFilter) async {
    if (newFilter == null) return;
    _currentFilter = newFilter;
    _filterStreamController.sink.add(newFilter);
    await getAllMyTickets();
  }

  Future<void> getAllMyTickets() async {
    final eventRequest = EventRequest(when: _currentFilter?.value);
    showOverLayLoading();
    final result = await _appRepo.getEvents(eventRequest, hasTicket: true);
    hideOverlayLoading();
    result.fold(
      (l) => _ticketsStreamController.sink.add(l),
      showError,
    );
  }
}

class MyTicketsTimeFilter {
  final int index;
  final String title;
  final String value;

  MyTicketsTimeFilter({
    required this.index,
    required this.title,
    required this.value,
  });
}
