import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/terms/terms_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/subjects.dart';

class TermsBloc extends BaseBloc {
  final AppRepository _appRepository;

  TermsBloc(this._appRepository);

  final _getTermsSubject = PublishSubject<BlocState<TermsResponse>>();

  Stream<BlocState<TermsResponse>> get getTermsStream => _getTermsSubject.stream;

  void getTerms(String titleUrl) async {
    final result = await _appRepository.getTerms(titleUrl);

    result.fold((data) {
      _getTermsSubject.sink.add(BlocState.success(data));
    }, (e) {
      _getTermsSubject.sink.add(BlocState.error(e.toString()));
    });
  }
}
