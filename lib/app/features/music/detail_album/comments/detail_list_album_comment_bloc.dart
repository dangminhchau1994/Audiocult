import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/comment_request.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/subjects.dart';
import '../../../../base/bloc_state.dart';
import '../../../../data_source/models/responses/comment/comment_response.dart';

class DetailListAlbumCommentBloc extends BaseBloc<CommentRequest, List<CommentResponse>> {
  final AppRepository _appRepository;

  DetailListAlbumCommentBloc(this._appRepository);

  final _createCommentSubject = PublishSubject<BlocState<CommentResponse>>();
  final _getRepliesSubject = PublishSubject<BlocState<List<CommentResponse>>>();

  Stream<BlocState<CommentResponse>> get createCommentStream => _createCommentSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getRepliesStream => _getRepliesSubject.stream;

  @override
  Future<Either<List<CommentResponse>, Exception>> loadData(CommentRequest? params) async {
    final result = await _appRepository.getComments(
      params?.id ?? 0,
      params?.typeId ?? '',
      params?.page ?? 0,
      params?.limit ?? 0,
    );
    return result;
  }

  void getReplies(int parentId, int id, String typeId, int page, int limit) async {
    final result = await _appRepository.getReplies(parentId, id, typeId, page, limit);

    result.fold((success) {
      _getRepliesSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getRepliesSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void createComment(int itemId, String type, String text) async {
    final result = await _appRepository.createComment(itemId, type, text);

    result.fold((success) {
      _createCommentSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createCommentSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
