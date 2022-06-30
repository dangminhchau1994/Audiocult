import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../utils/constants/app_colors.dart';

class FeedTypeVideo extends StatelessWidget {
  const FeedTypeVideo({
    Key? key,
    this.feedStatus,
    this.feedTitle,
    this.customDataCache,
    this.youtubePlayerController,
    this.totalView,
    this.flickVideoManager,
  }) : super(key: key);

  final String? feedStatus;
  final String? feedTitle;
  final String? totalView;
  final CustomDataCache? customDataCache;
  final YoutubePlayerController? youtubePlayerController;
  final FlickManager? flickVideoManager;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feedStatus ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 20),
        if (customDataCache?.videoUrl != null)
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoutubePlayer(
                  controller: youtubePlayerController!,
                  showVideoProgressIndicator: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    customDataCache?.title ?? '',
                    style: context.buttonTextStyle()!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${customDataCache?.videoTotalView ?? ''} views',
                    style: context.buttonTextStyle()!.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SelectableLinkify(
                    onOpen: (link) async {
                      await launchUrl(Uri.parse(link.url));
                    },
                    maxLines: 4,
                    linkStyle: TextStyle(color: AppColors.primaryButtonColor),
                    text: customDataCache?.text.toString() ?? '',
                    options: const LinkifyOptions(humanize: false),
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FlickVideoPlayer(
                    flickManager: flickVideoManager!,
                    flickVideoWithControls: const FlickVideoWithControls(
                      videoFit: BoxFit.contain,
                      closedCaptionTextStyle: TextStyle(fontSize: 8),
                      controls: FlickPortraitControls(),
                    ),
                    flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                      controls: FlickLandscapeControls(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    feedTitle ?? '',
                    style: context.buttonTextStyle()!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${totalView ?? ''} view',
                    style: context.buttonTextStyle()!.copyWith(
                          fontSize: 16,
                          color: AppColors.subTitleColor,
                        ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
