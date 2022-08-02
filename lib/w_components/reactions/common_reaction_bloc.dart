import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/post_reaction/post_reaction.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/base/bloc_state.dart';
import '../../app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import '../../app/data_source/repositories/app_repository.dart';

class CommonReactionBloc extends BaseBloc {
  final AppRepository _appRepository;

  CommonReactionBloc(this._appRepository);

  final _getReactionIconSubject = PublishSubject<BlocState<List<ReactionIconResponse>>>();
  final _postReactionIconSubject = PublishSubject<BlocState<PostReactionResponse>>();

  Stream<BlocState<List<ReactionIconResponse>>> get getReactionIconStream => _getReactionIconSubject.stream;
  Stream<BlocState<PostReactionResponse>> get postReactionIconStream => _postReactionIconSubject.stream;

  void getReactionIcons() async {
    final result = await _appRepository.getReactionIcons();

    result.fold((success) {
      _getReactionIconSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getReactionIconSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void postReactionIcon(String typeId, int itemId, int likeType) async {
    final result = await _appRepository.postReactionIcon(typeId, itemId, likeType);

    result.fold((success) {
      _postReactionIconSubject.sink.add(BlocState.success(success));
    }, (error) {
      _postReactionIconSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
