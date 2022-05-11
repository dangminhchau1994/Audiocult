import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/base/bloc_state.dart';
import '../../app/data_source/models/requests/comment_request.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../../app/data_source/repositories/app_repository.dart';

class ReplyListBloc extends BaseBloc<CommentRequest, List<CommentResponse>> {
  final AppRepository _appRepository;

  ReplyListBloc(this._appRepository);

  final _createReplySubject = PublishSubject<BlocState<CommentResponse>>();
  final _deleteCommentSubject = PublishSubject<BlocState<List<CommentResponse>>>();

  Stream<BlocState<CommentResponse>> get createReplyStream => _createReplySubject.stream;

  @override
  Future<Either<List<CommentResponse>, Exception>> loadData(CommentRequest? params) async {
    final result = await _appRepository.getReplies(
      params?.parentId ?? 0,
      params?.id ?? 0,
      params?.typeId ?? '',
      params?.page ?? 0,
      params?.limit ?? 0,
      params?.sort ?? '',
    );
    return result;
  }

  void deleteComment(int id) async {
    final result = await _appRepository.deleteComment(id);

    result.fold((success) {
      _deleteCommentSubject.sink.add(BlocState.success(success));
    }, (error) {
      _deleteCommentSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void createReply(int parentId, int itemId, String type, String text, {int? feedId}) async {
    final result = await _appRepository.createReply(parentId, itemId, type, text, feedId: feedId);

    result.fold((success) {
      _createReplySubject.sink.add(BlocState.success(success));
    }, (error) {
      _createReplySubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
