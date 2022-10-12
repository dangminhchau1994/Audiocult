import 'package:audio_cult/app/features/home/widgets/feed_type_event.dart';
import 'package:audio_cult/app/features/home/widgets/feed_type_link.dart';
import 'package:audio_cult/app/features/home/widgets/feed_type_photo.dart';
import 'package:audio_cult/app/features/home/widgets/feed_type_song.dart';
import 'package:audio_cult/app/features/home/widgets/feed_type_status.dart';
import 'package:audio_cult/app/features/home/widgets/feed_type_user_cover.dart';
import 'package:audio_cult/app/features/home/widgets/feed_type_user_photo.dart';
import 'package:audio_cult/app/features/home/widgets/feed_type_video.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../data_source/models/responses/feed/feed_response.dart';

class FeedItemContent extends StatefulWidget {
  const FeedItemContent({Key? key, this.data}) : super(key: key);

  final FeedResponse? data;

  @override
  State<FeedItemContent> createState() => _FeedItemContentState();
}

class _FeedItemContentState extends State<FeedItemContent> {
  late YoutubePlayerController _youtubePlayerController;
  late FlickManager _flickVideoManager;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.data?.customDataCache?.videoUrl.toString() ?? '',
      ).toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    _flickVideoManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.network(
        widget.data?.customDataCache?.destination.toString() ?? '',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _youtubePlayerController.dispose();
    _flickVideoManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (widget.data!.getFeedType()) {
      case FeedType.advancedEvent:
        final event = widget.data?.customDataCache;
        return FeedTypeEvent(
          event: event,
          eventId: widget.data?.itemId ?? '',
        );
      case FeedType.advancedSong:
        final song = widget.data?.customDataCache;
        return FeedTypeSong(
          song: song,
        );
      case FeedType.userStatus:
        final data = widget.data;
        return FeedTypeStatus(
          data: data,
        );
      case FeedType.photo:
        final data = widget.data;
        return FeedTypePhoto(
          data: data,
        );
      case FeedType.userCover:
        final data = widget.data?.feedImageUrl;
        return FeedTypeUserCover(
          feedImageUrl: data,
        );
      case FeedType.userPhoto:
        final data = widget.data?.feedImageUrl;
        return FeedTypeUserPhoto(
          feedImageUrl: data,
        );
      case FeedType.video:
        return FeedTypeVideo(
          feedStatus: widget.data?.feedStatus,
          feedTitle: widget.data?.feedTitle,
          customDataCache: widget.data?.customDataCache,
          youtubePlayerController: _youtubePlayerController,
          flickVideoManager: _flickVideoManager,
          totalView: widget.data?.totalView,
        );
      case FeedType.link:
        return FeedTypeLink(
          event: widget.data?.customDataCache,
        );
      case FeedType.none:
        return Container();
    }
  }
}
