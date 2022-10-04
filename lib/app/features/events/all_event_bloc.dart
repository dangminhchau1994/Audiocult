import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:dartz/dartz.dart';
import '../../data_source/repositories/app_repository.dart';

class AllEventBloc extends BaseBloc<EventRequest, List<EventResponse>> {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;

  String? get currentUserId {
    return _prefProvider.currentUserId;
  }

  AllEventBloc(this._appRepository, this._prefProvider);

  @override
  Future<Either<List<EventResponse>, Exception>> loadData(EventRequest? params) async {
    final result = await _appRepository.getEvents(params ?? EventRequest());
    return result;
  }
}
