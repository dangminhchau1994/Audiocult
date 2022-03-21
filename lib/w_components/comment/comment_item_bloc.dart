import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/base/bloc_state.dart';
import '../../app/data_source/repositories/app_repository.dart';

class CommentItemBloc extends BaseBloc {
  final AppRepository _appRepository;

  CommentItemBloc(this._appRepository);

  final _getReactionIconSubject = PublishSubject<BlocState<List<ReactionIconResponse>>>();

  Stream<BlocState<List<ReactionIconResponse>>> get getReactionIconStream => _getReactionIconSubject.stream;

  void getReactionIcons() async {
    final result = await _appRepository.getReactionIcons();

    result.fold((success) {
      _getReactionIconSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getReactionIconSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
