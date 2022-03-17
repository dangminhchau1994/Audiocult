import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../base/bloc_state.dart';
import '../../../../data_source/models/requests/comment_request.dart';
import '../../../../data_source/models/responses/comment/comment_response.dart';
import '../../../../data_source/repositories/app_repository.dart';

class DetailListAlbumRepliesBloc extends BaseBloc<CommentRequest, List<CommentResponse>> {
  final AppRepository _appRepository;

  DetailListAlbumRepliesBloc(this._appRepository);

  final _createReplySubject = PublishSubject<BlocState<CommentResponse>>();

  Stream<BlocState<CommentResponse>> get createReplyStream => _createReplySubject.stream;

  @override
  Future<Either<List<CommentResponse>, Exception>> loadData(CommentRequest? params) async {
    final result = await _appRepository.getReplies(
      params?.parentId ?? 0,
      params?.id ?? 0,
      params?.typeId ?? '',
      params?.page ?? 0,
      params?.limit ?? 0,
    );
    return result;
  }

  void createReply(int parentId, int itemId, String type, String text) async {
    final result = await _appRepository.createReply(parentId, itemId, type, text);

    result.fold((success) {
      _createReplySubject.sink.add(BlocState.success(success));
    }, (error) {
      _createReplySubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
