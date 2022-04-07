import 'package:dartz/dartz.dart';

import '../../base/base_bloc.dart';
import '../../data_source/models/requests/event_request.dart';
import '../../data_source/models/responses/events/event_response.dart';
import '../../data_source/repositories/app_repository.dart';

class PopularEventBloc extends BaseBloc<EventRequest, List<EventResponse>> {
  final AppRepository _appRepository;

  PopularEventBloc(this._appRepository);

  @override
  Future<Either<List<EventResponse>, Exception>> loadData(EventRequest? params) async {
    final result = await _appRepository.getEvents(params ?? EventRequest());
    return result;
  }
}
