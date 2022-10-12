import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/requests/feed_request.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../data_source/models/responses/events/event_category_response.dart';
import '../../../data_source/models/responses/feed/feed_response.dart';
import '../../../data_source/models/responses/playlist/delete_playlist_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class EventDetailBloc extends BaseBloc<FeedRequest, List<FeedResponse>> {
  final AppRepository _appRepository;

  EventDetailBloc(this._appRepository);

  final _getEventDetailSubject = PublishSubject<BlocState<EventResponse>>();
  final _updateEventSubject = PublishSubject<BlocState<List<EventResponse>>>();
  final _getEventCategoriesSubject = PublishSubject<BlocState<List<EventCategoryResponse>>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _pagingControllerSubject = PublishSubject<PagingController<int, FeedResponse>>();
  final _deleteFeedSubject = PublishSubject<BlocState<List<DeletePlayListResponse>>>();

  Stream<PagingController<int, FeedResponse>> get pagingControllerStream => _pagingControllerSubject.stream;
  Stream<BlocState<List<EventCategoryResponse>>> get getEventCategoriesStream => _getEventCategoriesSubject.stream;
  Stream<BlocState<EventResponse>> get getEventDetailStream => _getEventDetailSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<EventResponse>>> get udpateEventStream => _updateEventSubject.stream;
  Stream<BlocState<List<DeletePlayListResponse>>> get deleteFeedStream => _deleteFeedSubject.stream;

  void deleteFeedItem(PagingController<int, FeedResponse> pagingController, int index) {
    pagingController.itemList?.removeAt(index);
    _pagingControllerSubject.sink.add(pagingController);
  }

  void editFeedItem(PagingController<int, FeedResponse> pagingController, FeedResponse feed) {
    final index = pagingController.itemList!.indexWhere((element) => element.feedId == feed.feedId);
    pagingController.itemList?[index] = feed;
    _pagingControllerSubject.sink.add(pagingController);
  }

  void deleteFeed(int id) async {
    final result = await _appRepository.deleteFeed(id);

    result.fold((success) {
      _deleteFeedSubject.sink.add(BlocState.success(success));
    }, (error) {
      _deleteFeedSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getEventCategories() async {
    final result = await _appRepository.getEventCategories();

    result.fold((success) {
      _getEventCategoriesSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getEventCategoriesSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void updateEventStatus(int id, int rsvp) async {
    final result = await _appRepository.updateEventStatus(id, rsvp);

    result.fold((success) {
      _updateEventSubject.sink.add(BlocState.success(success));
    }, (error) {
      _updateEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getEventDetail(int id) async {
    _getEventDetailSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getEventDetail(id);

    result.fold((success) {
      _getEventDetailSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getEventDetailSubject.sink.add(BlocState.error(error.toString()));
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
    final result = await _appRepository.getFeeds(params ?? FeedRequest());
    return result;
  }
}
