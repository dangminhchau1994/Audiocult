import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../data_source/models/responses/feed/feed_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/route/app_route.dart';

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
    return _buildBody(
      widget.data!.getFeedType(),
      widget.data!,
      context,
      _youtubePlayerController,
      _flickVideoManager,
    );
  }
}

Widget _buildBody(
  FeedType feedType,
  FeedResponse data,
  BuildContext context,
  YoutubePlayerController youtubePlayerController,
  FlickManager flickManager,
) {
  switch (feedType) {
    case FeedType.advancedEvent:
      return Html(
        data: data.feedCustomHtml ?? '',
      );
    case FeedType.advancedSong:
      return Container(
        padding: const EdgeInsets.all(14),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.customDataCache?.title ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: data.customDataCache?.totalPlay ?? '0',
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                      TextSpan(
                        text: '  plays',
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 14,
                              color: AppColors.subTitleColor,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.routeDetailSong,
                      arguments: {'song_id': data.customDataCache!.songId},
                    );
                  },
                  child: SvgPicture.asset(
                    AppAssets.songDetailIcon,
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.download,
                  color: Colors.white,
                  size: 28,
                )
              ],
            )
          ],
        ),
      );
    case FeedType.userStatus:
      if (data.statusBackground!.isEmpty) {
        return Text(
          data.feedStatus ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
        );
      } else {
        return Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: data.statusBackground ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                  child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minHeight: 50),
                child: const LoadingWidget(),
              )),
              errorWidget: (
                BuildContext context,
                _,
                __,
              ) =>
                  const Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/cover.jpg',
                ),
              ),
            ),
            Text(
              data.feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
            ),
          ],
        );
      }
    case FeedType.photo:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.feedStatus ?? '',
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 20),
          if (data.apiFeedImage != null)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.5,
              children: data.feedImageUrl!
                  .map(
                    (e) => CachedNetworkImage(
                      imageUrl: e,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
            )
          else
            const SizedBox(),
        ],
      );
    case FeedType.userCover:
      return CachedNetworkImage(
        imageUrl: data.feedImageUrl?[0] ?? '',
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
            child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 50),
          child: const LoadingWidget(),
        )),
        errorWidget: (
          BuildContext context,
          _,
          __,
        ) =>
            const Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/cover.jpg',
          ),
        ),
      );
    case FeedType.userPhoto:
      return CachedNetworkImage(
        imageUrl: data.feedImageUrl?[0] ?? '',
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
            child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 50),
          child: const LoadingWidget(),
        )),
        errorWidget: (
          BuildContext context,
          _,
          __,
        ) =>
            const Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/cover.jpg',
          ),
        ),
      );
    case FeedType.video:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.feedStatus ?? '',
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 20),
          if (data.customDataCache?.videoUrl != null)
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoutubePlayer(
                    controller: youtubePlayerController,
                    showVideoProgressIndicator: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      data.customDataCache?.title ?? '',
                      style: context.buttonTextStyle()!.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${data.customDataCache?.videoTotalView ?? ''} views',
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
                      text: data.customDataCache?.text.toString() ?? '',
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
                  FlickVideoPlayer(
                    flickManager: flickManager,
                    flickVideoWithControls: const FlickVideoWithControls(
                      closedCaptionTextStyle: TextStyle(fontSize: 8),
                      controls: FlickPortraitControls(),
                    ),
                    flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                      controls: FlickLandscapeControls(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      data.feedTitle ?? '',
                      style: context.buttonTextStyle()!.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${data.totalView ?? ''} view',
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
    case FeedType.none:
      return Container();
  }
}
