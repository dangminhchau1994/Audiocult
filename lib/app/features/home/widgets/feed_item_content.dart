import 'dart:typed_data';

import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../w_components/loading/loading_widget.dart';
import '../../../data_source/models/responses/feed/feed_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/file/file_utils.dart';
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
  final Set<Marker> markers = {};
  late GoogleMapController _controller;
  Uint8List? _iconMarker;

  void _getCustomMarker() {
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        _iconMarker = value;
      });
    });
  }

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
    _getCustomMarker();
  }

  @override
  void dispose() {
    super.dispose();
    _youtubePlayerController.dispose();
    _flickVideoManager.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (widget.data!.getFeedType()) {
      case FeedType.advancedEvent:
        final event = widget.data?.customDataCache;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonImageNetWork(
              width: double.infinity,
              height: 200,
              imagePath: event?.imagePath,
            ),
            const SizedBox(height: 10),
            Text(
              '${DateTimeUtils.formatyMMMMd(int.parse(event?.startTime ?? ''))} - ${DateTimeUtils.formatyMMMMd(
                int.parse(event?.endTime ?? ''),
              )}',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              event?.title ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 18,
                    color: AppColors.primaryButtonColor,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              event?.location ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
            )
          ],
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
                widget.data?.customDataCache?.title ?? '',
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
                          text: widget.data?.customDataCache?.totalPlay ?? '0',
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
                        arguments: {'song_id': widget.data?.customDataCache!.songId},
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
        if (widget.data!.statusBackground!.isEmpty && widget.data?.locationName == null) {
          return Text(
            widget.data?.feedStatus ?? '',
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          );
        } else if (widget.data?.locationName != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data?.feedStatus ?? '',
                style: context.buttonTextStyle()!.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 300,
                child: GoogleMap(
                  gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      EagerGestureRecognizer.new,
                    ),
                  },
                  onTap: (lng) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.data?.locationLatlng?.latitude ?? 0.0,
                      widget.data?.locationLatlng?.longitude ?? 0.0,
                    ),
                    zoom: 10,
                  ),
                  markers: {
                    if (_iconMarker != null)
                      Marker(
                        markerId: const MarkerId(''),
                        position: LatLng(
                          widget.data?.locationLatlng?.latitude ?? 0.0,
                          widget.data?.locationLatlng?.longitude ?? 0.0,
                        ),
                        icon: BitmapDescriptor.fromBytes(_iconMarker!),
                      )
                  },
                  onMapCreated: (controller) {
                    _controller = controller;
                    FileUtils.getJsonFile(AppAssets.nightMapJson).then((value) {
                      _controller.setMapStyle(value);
                    });
                  },
                ),
              ),
            ],
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: widget.data?.statusBackground ?? '',
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
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.data?.feedStatus ?? '',
                  textAlign: TextAlign.center,
                  style: context.buttonTextStyle()!.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
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
              widget.data?.feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            if (widget.data?.apiFeedImage != null)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                children: widget.data!.feedImageUrl!
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
          imageUrl: widget.data?.feedImageUrl?[0] ?? '',
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
          imageUrl: widget.data?.feedImageUrl?[0] ?? '',
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
              widget.data?.feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            if (widget.data?.customDataCache?.videoUrl != null)
              Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(
                      controller: _youtubePlayerController,
                      showVideoProgressIndicator: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.data?.customDataCache?.title ?? '',
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${widget.data?.customDataCache?.videoTotalView ?? ''} views',
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
                        text: widget.data?.customDataCache?.text.toString() ?? '',
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
                      flickManager: _flickVideoManager,
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
                        widget.data?.feedTitle ?? '',
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${widget.data?.totalView ?? ''} view',
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
}
