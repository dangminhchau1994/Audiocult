import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/create_post_request.dart';
import 'package:audio_cult/app/data_source/models/requests/feed_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_photo_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_video_request.dart';
import 'package:audio_cult/app/data_source/models/responses/announcement/announcement_response.dart';
import 'package:audio_cult/app/data_source/models/responses/create_post/create_post_response.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/delete_playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/post_reaction/post_reaction.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_photo/upload_photo_response.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_video/upload_video_response.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rxdart/subjects.dart';
import '../../data_source/models/responses/background/background_response.dart';
import '../../data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import '../../data_source/repositories/app_repository.dart';

class HomeBloc extends BaseBloc<FeedRequest, List<FeedResponse>> {
  final AppRepository _appRepository;

  HomeBloc(this._appRepository);

  final _getAnnouncementSubject = PublishSubject<BlocState<List<AnnouncementResponse>>>();
  final _getReactionIconSubject = PublishSubject<BlocState<List<ReactionIconResponse>>>();
  final _postReactionIconSubject = PublishSubject<BlocState<PostReactionResponse>>();
  final _getBackgroundSubject = PublishSubject<BlocState<List<BackgroundResponse>>>();
  final _createPostSubject = PublishSubject<BlocState<CreatePostResponse>>();
  final _uploadPhotoSubject = PublishSubject<BlocState<List<UploadPhotoResponse>>>();
  final _uploadVideoSubject = PublishSubject<BlocState<UploadVideoResponse>>();
  final _deleteFeedSubject = PublishSubject<BlocState<List<DeletePlayListResponse>>>();
  final _pagingControllerSubject = PublishSubject<PagingController<int, FeedResponse>>();
  final _createPostEventSubject = PublishSubject<BlocState<CreatePostResponse>>();

  Stream<PagingController<int, FeedResponse>> get pagingControllerStream => _pagingControllerSubject.stream;
  Stream<BlocState<List<AnnouncementResponse>>> get getAnnoucementStream => _getAnnouncementSubject.stream;
  Stream<BlocState<List<ReactionIconResponse>>> get getReactionIconStream => _getReactionIconSubject.stream;
  Stream<BlocState<PostReactionResponse>> get postReactionIconStream => _postReactionIconSubject.stream;
  Stream<BlocState<List<BackgroundResponse>>> get getBackgroundStream => _getBackgroundSubject.stream;
  Stream<BlocState<CreatePostResponse>> get createPostStream => _createPostSubject.stream;
  Stream<BlocState<CreatePostResponse>> get createPostEventStream => _createPostEventSubject.stream;
  Stream<BlocState<List<UploadPhotoResponse>>> get uploadPhotoStream => _uploadPhotoSubject.stream;
  Stream<BlocState<UploadVideoResponse>> get uploadVideoStream => _uploadVideoSubject.stream;
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

  void postStatus(CreatePostRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.createPost(request);
    hideOverlayLoading();

    result.fold((success) {
      _createPostSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createPostSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void postStatusEvent(CreatePostRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.createPostEvent(request);
    hideOverlayLoading();

    result.fold((success) {
      _createPostEventSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createPostEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void uploadVideo(UploadVideoRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.uploadVideo(request);
    hideOverlayLoading();

    result.fold((success) {
      _uploadVideoSubject.sink.add(BlocState.success(success));
    }, (error) {
      _uploadVideoSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void uploadPhoto(UploadPhotoRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.uploadPhoto(request);
    hideOverlayLoading();

    result.fold((success) {
      _uploadPhotoSubject.sink.add(BlocState.success(success));
    }, (error) {
      _uploadPhotoSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getReactionIcons() async {
    final result = await _appRepository.getReactionIcons();

    result.fold((success) {
      _getReactionIconSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getReactionIconSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getBackgrounds() async {
    _getBackgroundSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getBackgrounds();

    result.fold((success) {
      _getBackgroundSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getBackgroundSubject.sink.add(BlocState.error(error.toString()));
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

  @override
  Future<Either<List<FeedResponse>, Exception>> loadData(FeedRequest? params) async {
    final result = await _appRepository.getFeeds(params ?? FeedRequest());
    return result;
  }
}
