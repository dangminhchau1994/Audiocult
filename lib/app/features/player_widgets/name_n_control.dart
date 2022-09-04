import 'dart:math';
import 'dart:ui' as ui;

import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../w_components/customizes/animated_text.dart';
import '../../../w_components/wave_music/wave_progress_bars.dart';
import '../../utils/route/app_route.dart';
import '../audio_player/audio_player.dart';
import '../audio_player/miniplayer.dart';
import '../profile/profile_screen.dart';

class NameNControls extends StatefulWidget {
  final MediaItem mediaItem;
  final double width;
  final double height;
  final PanelController panelController;
  final AudioPlayerHandler audioHandler;

  // ignore: use_key_in_widget_constructors
  const NameNControls({
    required this.width,
    required this.height,
    required this.mediaItem,
    required this.audioHandler,
    required this.panelController,
  });

  @override
  State<NameNControls> createState() => _NameNControlsState();
}

class _NameNControlsState extends State<NameNControls> {
  Stream<Duration> get _bufferedPositionStream =>
      widget.audioHandler.playbackState.map((state) => state.bufferedPosition).distinct();

  Stream<Duration?> get _durationStream => widget.audioHandler.mediaItem.map((item) => item?.duration).distinct();

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        AudioService.position,
        _bufferedPositionStream,
        _durationStream,
        (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );
  final waveProgressKey = GlobalKey<WaveProgressBarState>();
  List<double> values = [];
  @override
  void initState() {
    super.initState();
    final rng = Random();
    for (var i = 0; i < 150; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
    AudioService.position.listen((event) {
      waveProgressKey.currentState?.updateUIProgress((event.inSeconds / widget.mediaItem.duration!.inSeconds) * 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

    final titleBoxHeight = widget.height * 0.25;
    // final seekBoxHeight = height > 500 ? height * 0.15 : height * 0.2;
    final controlBoxHeight = widget.height < 350
        ? widget.height * 0.4
        : widget.height > 500
            ? widget.height * 0.2
            : widget.height * 0.3;
    final nowPlayingBoxHeight = widget.height > 500 ? widget.height * 0.4 : widget.height * 0.15;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// Title and subtitle
              SizedBox(
                height: titleBoxHeight,
                child: PopupMenuButton<int>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  offset: const Offset(1, 0),
                  onSelected: (int value) {
                    if (value == 0) {
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     opaque: false,
                      //     pageBuilder: (_, __, ___) => SongsListPage(
                      //       listItem: {
                      //         'type': 'album',
                      //         'id': mediaItem.extras?['album_id'],
                      //         'title': mediaItem.album,
                      //         'image': mediaItem.artUri,
                      //       },
                      //     ),
                      //   ),
                      // );
                    }
                    if (value == 5) {
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     opaque: false,
                      //     pageBuilder: (_, __, ___) => AlbumSearchPage(
                      //       query:
                      //           mediaItem.artist.toString().split(', ').first,
                      //       type: 'Artists',
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    // if (widget.mediaItem.extras?['album_id'] != null)
                    //   PopupMenuItem<int>(
                    //     value: 0,
                    //     child: Row(
                    //       children: const [
                    //         Icon(
                    //           Icons.album_rounded,
                    //         ),
                    //         SizedBox(width: 10),
                    //         Text(
                    //           'View Albums',
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // if (widget.mediaItem.artist != null)
                    // PopupMenuItem<int>(
                    //   value: 5,
                    //   child: Row(
                    //     children: const [
                    //       Icon(
                    //         Icons.person_rounded,
                    //       ),
                    //       SizedBox(width: 10),
                    //       Text(
                    //         'View Artist',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),

                          /// Title container
                          AnimatedText(
                            text: widget.mediaItem.title.split(' (')[0].split('|')[0].trim(),
                            pauseAfterRound: const Duration(seconds: 3),
                            showFadingOnlyWhenScrolling: false,
                            fadingEdgeEndFraction: 0.1,
                            fadingEdgeStartFraction: 0.1,
                            startAfter: const Duration(seconds: 2),
                            style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          /// Subtitle container
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                AppRoute.routeProfile,
                                arguments: ProfileScreen.createArguments(
                                  id: widget.mediaItem.displayTitle ?? '',
                                ),
                              );
                            },
                            child: AnimatedText(
                              text: '${widget.mediaItem.artist ?? "Unknown"} • ${widget.mediaItem.album ?? "Unknown"}',
                              pauseAfterRound: const Duration(seconds: 3),
                              showFadingOnlyWhenScrolling: false,
                              fadingEdgeEndFraction: 0.1,
                              fadingEdgeStartFraction: 0.1,
                              startAfter: const Duration(seconds: 2),
                              style: context
                                  .bodyTextStyle()
                                  ?.copyWith(fontWeight: FontWeight.w300, color: AppColors.subTitleColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (values.isNotEmpty)
                WaveProgressBar(
                  key: waveProgressKey,
                  onChange: (percent) {
                    try {
                      final temp = percent / 100;
                      widget.audioHandler
                          .seek(Duration(seconds: (widget.mediaItem.duration!.inSeconds * temp).toInt()));
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  progressPercentage: 5,
                  listOfHeights: values,
                  width: queryData.size.width,
                  initialColor: Colors.grey,
                  progressColor: AppColors.activeLabelItem,
                  backgroundColor: AppColors.mainColor,
                  timeInMilliSeconds: 500,
                )
              else
                Container(),

              /// Seekbar starts from here
              SizedBox(
                height: 0,
                width: widget.width * 0.95,
                child: StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    // final positionData = snapshot.data ??
                    PositionData(
                      Duration.zero,
                      Duration.zero,
                      widget.mediaItem.duration ?? Duration.zero,
                    );
                    return Container();
                    // return SeekBar(
                    //   width: width,
                    //   height: height,
                    //   duration: positionData.duration,
                    //   position: positionData.position,
                    //   bufferedPosition: positionData.bufferedPosition,
                    //   offline: offline,
                    //   onChangeEnd: (newPosition) {
                    //     audioHandler.seek(newPosition);
                    //   },
                    //   audioHandler: audioHandler,
                    // );
                  },
                ),
              ),

              /// Final row starts from here
              SizedBox(
                height: controlBoxHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 6),
                              StreamBuilder<bool>(
                                stream: widget.audioHandler.playbackState
                                    .map(
                                      (state) => state.shuffleMode == AudioServiceShuffleMode.all,
                                    )
                                    .distinct(),
                                builder: (context, snapshot) {
                                  final shuffleModeEnabled = snapshot.data ?? false;
                                  return IconButton(
                                    icon: shuffleModeEnabled
                                        ? const Icon(
                                            Icons.shuffle_rounded,
                                          )
                                        : Icon(Icons.shuffle_rounded, color: AppColors.subTitleColor),
                                    onPressed: () async {
                                      final enable = !shuffleModeEnabled;
                                      await widget.audioHandler.setShuffleMode(
                                        enable ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          ControlButtons(
                            widget.audioHandler,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 6),
                              StreamBuilder<AudioServiceRepeatMode>(
                                stream: widget.audioHandler.playbackState.map((state) => state.repeatMode).distinct(),
                                builder: (context, snapshot) {
                                  final repeatMode = snapshot.data ?? AudioServiceRepeatMode.none;
                                  const texts = ['None', 'All', 'One'];
                                  final icons = [
                                    Icon(Icons.repeat_rounded, color: AppColors.subTitleColor),
                                    const Icon(
                                      Icons.repeat_rounded,
                                    ),
                                    const Icon(
                                      Icons.repeat_one_rounded,
                                    ),
                                  ];
                                  const cycleModes = [
                                    AudioServiceRepeatMode.none,
                                    AudioServiceRepeatMode.all,
                                    AudioServiceRepeatMode.one,
                                  ];
                                  final index = cycleModes.indexOf(repeatMode);
                                  return IconButton(
                                    icon: icons[index],
                                    tooltip: 'Repeat ${texts[(index + 1) % texts.length]}',
                                    onPressed: () {
                                      // Hive.box('settings').put(
                                      //   'repeatMode',
                                      //   texts[(index + 1) % texts.length],
                                      // );
                                      widget.audioHandler.setRepeatMode(
                                        cycleModes[(cycleModes.indexOf(repeatMode) + 1) % cycleModes.length],
                                      );
                                    },
                                  );
                                },
                              ),
                              // if (!offline)
                              //   DownloadButton(
                              //     size: 25.0,
                              //     data: MediaItemConverter.mediaItemtoMap(
                              //       mediaItem,
                              //     ),
                              //   )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: nowPlayingBoxHeight,
              ),
            ],
          ),

          // Up Next with blur background
          SlidingUpPanel(
            minHeight: nowPlayingBoxHeight,
            maxHeight: 350,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            boxShadow: const [],
            color: Colors.transparent,
            // gradientColor?[1]?.withOpacity(1.0) ??
            //     // useBlurForNowPlaying
            //     //     ? Theme.of(context).brightness == Brightness.dark
            //     Colors.black.withOpacity(0.2),
            //     : Colors.white.withOpacity(0.7)
            // : Theme.of(context).brightness == Brightness.dark
            //     ? Colors.black
            //     : Colors.white,
            controller: widget.panelController,
            panelBuilder: (ScrollController scrollController) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 50,
                    sigmaY: 50,
                  ),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.center,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ).createShader(
                        Rect.fromLTRB(
                          0,
                          0,
                          rect.width,
                          rect.height,
                        ),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: NowPlayingStream(
                      head: true,
                      headHeight: nowPlayingBoxHeight,
                      audioHandler: widget.audioHandler,
                      scrollController: scrollController,
                    ),
                  ),
                ),
              );
            },
            header: GestureDetector(
              onTap: () {
                if (widget.panelController.isPanelOpen) {
                  widget.panelController.close();
                } else {
                  if (widget.panelController.panelPosition > 0.9) {
                    widget.panelController.close();
                  } else {
                    widget.panelController.open();
                  }
                }
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                if (details.delta.dy > 0.0) {
                  widget.panelController.animatePanelToPosition(0);
                }
              },
              child: Container(
                height: nowPlayingBoxHeight,
                width: widget.width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: SizedBox(width: 30, height: 5, child: Icon(Icons.keyboard_arrow_up_rounded)),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          context.localize.t_current_playlist,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w400, color: AppColors.unActiveLabelItem),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
