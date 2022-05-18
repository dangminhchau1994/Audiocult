import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/feed_request.dart';
import 'package:audio_cult/app/data_source/models/responses/announcement/announcement_response.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/subjects.dart';
import '../../data_source/models/responses/comment/comment_response.dart';
import '../../data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import '../../data_source/repositories/app_repository.dart';

class HomeBloc extends BaseBloc<FeedRequest, List<FeedResponse>> {
  final AppRepository _appRepository;

  HomeBloc(this._appRepository);

  final _getAnnouncementSubject = PublishSubject<BlocState<List<AnnouncementResponse>>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _getReactionIconSubject = PublishSubject<BlocState<List<ReactionIconResponse>>>();
  final _postReactionIconSubject = PublishSubject<BlocState<CommentResponse>>();

  Stream<BlocState<List<AnnouncementResponse>>> get getAnnoucementStream => _getAnnouncementSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<ReactionIconResponse>>> get getReactionIconStream => _getReactionIconSubject.stream;
  Stream<BlocState<CommentResponse>> get postReactionIconStream => _postReactionIconSubject.stream;

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

  void getAnnouncements(int page, int limit) async {
    _getAnnouncementSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getAnnouncements(page, limit);

    result.fold((success) {
      _getAnnouncementSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getAnnouncementSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getComments(int id, String typeId, int page, int limit, String sort) async {
    _getCommentsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getComments(id, typeId, page, limit, sort);

    result.fold((success) {
      _getCommentsSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getCommentsSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  @override
  Future<Either<List<FeedResponse>, Exception>> loadData(FeedRequest? params) async {
    final result = await _appRepository.getFeeds(params?.page ?? 0, params?.limit ?? 0, params?.lastFeedId ?? 0);
    return result;
  }
}
