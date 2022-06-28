import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/create_post_request.dart';
import 'package:audio_cult/app/data_source/models/requests/feed_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_photo_request.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_video_request.dart';
import 'package:audio_cult/app/data_source/models/responses/announcement/announcement_response.dart';
import 'package:audio_cult/app/data_source/models/responses/create_post/create_post_response.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_photo/upload_photo_response.dart';
import 'package:audio_cult/app/data_source/models/responses/upload_video/upload_video_response.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/subjects.dart';
import '../../data_source/models/responses/background/background_response.dart';
import '../../data_source/models/responses/comment/comment_response.dart';
import '../../data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import '../../data_source/repositories/app_repository.dart';

class HomeBloc extends BaseBloc<FeedRequest, List<FeedResponse>> {
  final AppRepository _appRepository;

  HomeBloc(this._appRepository);

  final _getAnnouncementSubject = PublishSubject<BlocState<List<AnnouncementResponse>>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _getReactionIconSubject = PublishSubject<BlocState<List<ReactionIconResponse>>>();
  final _postReactionIconSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _getBackgroundSubject = PublishSubject<BlocState<List<BackgroundResponse>>>();
  final _createPostSubject = PublishSubject<BlocState<CreatePostResponse>>();
  final _uploadPhotoSubject = PublishSubject<BlocState<List<UploadPhotoResponse>>>();
  final _uploadVideoSubject = PublishSubject<BlocState<UploadVideoResponse>>();

  Stream<BlocState<List<AnnouncementResponse>>> get getAnnoucementStream => _getAnnouncementSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<ReactionIconResponse>>> get getReactionIconStream => _getReactionIconSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get postReactionIconStream => _postReactionIconSubject.stream;
  Stream<BlocState<List<BackgroundResponse>>> get getBackgroundStream => _getBackgroundSubject.stream;
  Stream<BlocState<CreatePostResponse>> get createPostStream => _createPostSubject.stream;
  Stream<BlocState<List<UploadPhotoResponse>>> get uploadPhotoStream => _uploadPhotoSubject.stream;
  Stream<BlocState<UploadVideoResponse>> get uploadVideoStream => _uploadVideoSubject.stream;

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
