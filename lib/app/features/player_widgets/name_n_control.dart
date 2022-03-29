import 'dart:ui' as ui;

import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../w_components/customizes/animated_text.dart';
import '../audio_player/audio_player.dart';
import '../audio_player/miniplayer.dart';

class NameNControls extends StatelessWidget {
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

  Stream<Duration> get _bufferedPositionStream =>
      audioHandler.playbackState.map((state) => state.bufferedPosition).distinct();
  Stream<Duration?> get _durationStream => audioHandler.mediaItem.map((item) => item?.duration).distinct();
  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        AudioService.position,
        _bufferedPositionStream,
        _durationStream,
        (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    final titleBoxHeight = height * 0.25;
    // final seekBoxHeight = height > 500 ? height * 0.15 : height * 0.2;
    final controlBoxHeight = height < 350
        ? height * 0.4
        : height > 500
            ? height * 0.2
            : height * 0.3;
    final nowPlayingBoxHeight = height > 500 ? height * 0.4 : height * 0.15;
    return SizedBox(
      width: width,
      height: height,
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
                    if (mediaItem.extras?['album_id'] != null)
                      PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.album_rounded,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'View Albums',
                            ),
                          ],
                        ),
                      ),
                    if (mediaItem.artist != null)
                      PopupMenuItem<int>(
                        value: 5,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.person_rounded,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'View Artist',
                            ),
                          ],
                        ),
                      ),
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
                            text: mediaItem.title.split(' (')[0].split('|')[0].trim(),
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
                          AnimatedText(
                            text: '${mediaItem.artist ?? "Unknown"} • ${mediaItem.album ?? "Unknown"}',
                            pauseAfterRound: const Duration(seconds: 3),
                            showFadingOnlyWhenScrolling: false,
                            fadingEdgeEndFraction: 0.1,
                            fadingEdgeStartFraction: 0.1,
                            startAfter: const Duration(seconds: 2),
                            style: context
                                .bodyTextStyle()
                                ?.copyWith(fontWeight: FontWeight.w300, color: AppColors.subTitleColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Seekbar starts from here
              SizedBox(
                height: 0,
                width: width * 0.95,
                child: StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    // final positionData = snapshot.data ??
                    PositionData(
                      Duration.zero,
                      Duration.zero,
                      mediaItem.duration ?? Duration.zero,
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
                                stream: audioHandler.playbackState
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
                                        : Icon(
                                            Icons.shuffle_rounded,
                                            color: Theme.of(context).disabledColor,
                                          ),
                                    onPressed: () async {
                                      final enable = !shuffleModeEnabled;
                                      await audioHandler.setShuffleMode(
                                        enable ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          ControlButtons(
                            audioHandler,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 6),
                              StreamBuilder<AudioServiceRepeatMode>(
                                stream: audioHandler.playbackState.map((state) => state.repeatMode).distinct(),
                                builder: (context, snapshot) {
                                  final repeatMode = snapshot.data ?? AudioServiceRepeatMode.none;
                                  const texts = ['None', 'All', 'One'];
                                  final icons = [
                                    Icon(
                                      Icons.repeat_rounded,
                                      color: Theme.of(context).disabledColor,
                                    ),
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
                                      audioHandler.setRepeatMode(
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
            controller: panelController,
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
                      audioHandler: audioHandler,
                      scrollController: scrollController,
                    ),
                  ),
                ),
              );
            },
            header: GestureDetector(
              onTap: () {
                if (panelController.isPanelOpen) {
                  panelController.close();
                } else {
                  if (panelController.panelPosition > 0.9) {
                    panelController.close();
                  } else {
                    panelController.open();
                  }
                }
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                if (details.delta.dy > 0.0) {
                  panelController.animatePanelToPosition(0);
                }
              },
              child: Container(
                height: nowPlayingBoxHeight,
                width: width,
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
                          'Current Playlist',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.unActiveLabelItem),
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