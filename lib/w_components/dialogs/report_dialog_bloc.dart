import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/report_request.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/reasons/reason_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/subjects.dart';

class ReportDialogBloc extends BaseBloc {
  final AppRepository _appRepository;

  ReportDialogBloc(this._appRepository);

  final _getReasonSubject = PublishSubject<BlocState<List<ReasonResponse>>>();
  final _reportSubject = PublishSubject<BlocState<List<CommentResponse>>>();

  Stream<BlocState<List<ReasonResponse>>> get getReasonStream => _getReasonSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get reportStream => _reportSubject.stream;

  void getReasons() async {
    final result = await _appRepository.getReasons();

    result.fold((data) {
      _getReasonSubject.sink.add(BlocState.success(data));
    }, (e) {
      _getReasonSubject.sink.add(BlocState.error(e.toString()));
    });
  }

  void report(ReportRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.report(request);
    hideOverlayLoading();

    result.fold((data) {
      _reportSubject.sink.add(BlocState.success(data));
    }, (e) {
      _reportSubject.sink.add(BlocState.error(e.toString()));
    });
  }
}
