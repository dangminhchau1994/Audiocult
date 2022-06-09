import 'package:audio_cult/app/data_source/models/responses/video_data.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video? data;
  const VideoPlayerScreen({Key? key, this.data}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late FlickManager flickManager;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.data?.destination == null) {
      String? videoId;
      videoId = YoutubePlayer.convertUrlToId(widget.data?.videoUrl ?? '');
      _controller = YoutubePlayerController(
        initialVideoId: videoId ?? '',
      );
    }

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.data?.destination ?? '',
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: widget.data?.title ?? '',
      ),
      body: widget.data?.destination != null
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: const FlickVideoWithControls(
                  videoFit: BoxFit.contain,
                  closedCaptionTextStyle: TextStyle(fontSize: 8),
                  controls: FlickPortraitControls(),
                ),
                flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                ),
              ),
            )
          : Theme(
              data: Theme.of(context).copyWith(cardColor: AppColors.mainColor),
              child: YoutubePlayer(
                showVideoProgressIndicator: true,
                controller: _controller,
                liveUIColor: Colors.amber,
              ),
            ),
    );
  }
}
