import 'dart:io';

import 'package:audio_cult/app/features/audio_player/queue_state.dart';
import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/route/app_route.dart';
import '../player_widgets/player_screen.dart';
import 'audio_player.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState,
      builder: (context, snapshot) {
        final playbackState = snapshot.data;
        final processingState = playbackState?.processingState;
        if (processingState == AudioProcessingState.idle) {
          return const SizedBox();
        }
        return StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const SizedBox();
            }
            final mediaItem = snapshot.data;
            if (mediaItem == null) return const SizedBox();
            return Dismissible(
              background: Container(color: Colors.transparent),
              key: Key(mediaItem.id),
              onDismissed: (_) {
                Feedback.forLongPress(context);
                audioHandler.stop();
              },
              child: ValueListenableBuilder(
                valueListenable: Hive.box('settings').listenable(),
                child: StreamBuilder<Duration>(
                  stream: AudioService.position,
                  builder: (context, snapshot) {
                    final position = snapshot.data;
                    return position == null
                        ? const SizedBox()
                        : (position.inSeconds.toDouble() < 0.0 ||
                                (position.inSeconds.toDouble() > mediaItem.duration!.inSeconds.toDouble()))
                            ? const SizedBox()
                            : SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                                  inactiveTrackColor: Colors.transparent,
                                  trackHeight: 0.5,
                                  thumbColor: Theme.of(context).colorScheme.secondary,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 1,
                                  ),
                                  overlayColor: Colors.transparent,
                                  overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Slider(
                                    inactiveColor: Colors.transparent,
                                    // activeColor: Colors.white,
                                    value: position.inSeconds.toDouble(),
                                    max: mediaItem.duration!.inSeconds.toDouble(),
                                    onChanged: (newPosition) {
                                      audioHandler.seek(
                                        Duration(
                                          seconds: newPosition.round(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                  },
                ),
                builder: (BuildContext context, Box box1, Widget? child) {
                  final useDense = box1.get(
                    'useDenseMini',
                    defaultValue: false,
                  ) as bool;
                  final preferredMiniButtons = Hive.box('settings').get(
                    'preferredMiniButtons',
                    defaultValue: ['Previous', 'Play/Pause', 'Next'],
                  )?.toList() as List;
                  return Container(
                    color: AppColors.secondaryButtonColor.withOpacity(0.75),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 1,
                    ),
                    child: SizedBox(
                      height: useDense ? 68.0 : 76.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            dense: useDense,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routePlayerScreen,
                                arguments: PlayerScreen.createArguments(listSong: [], index: 1),
                              );
                            },
                            title: Text(
                              mediaItem.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              mediaItem.artist ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Hero(
                              tag: 'currentArtwork',
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: (mediaItem.artUri.toString().startsWith('file:'))
                                    ? SizedBox.square(
                                        dimension: useDense ? 40.0 : 40.0,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                            File(
                                              mediaItem.artUri!.toFilePath(),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox.square(
                                        dimension: useDense ? 40.0 : 50.0,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
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
                                          placeholder: (
                                            BuildContext context,
                                            _,
                                          ) =>
                                              const Image(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/cover.jpg',
                                            ),
                                          ),
                                          imageUrl: mediaItem.artUri.toString(),
                                        ),
                                      ),
                              ),
                            ),
                            trailing: ControlButtons(
                              audioHandler,
                              minelayer: true,
                              buttons: mediaItem.artUri.toString().startsWith('file:')
                                  ? ['Previous', 'Play/Pause', 'Next']
                                  : preferredMiniButtons,
                            ),
                          ),
                          //  child!,
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayerHandler audioHandler;
  final bool shuffle;
  final bool minelayer;
  final List buttons;
  final Color? dominantColor;

  // ignore: use_key_in_widget_constructors
  const ControlButtons(
    this.audioHandler, {
    this.shuffle = false,
    this.minelayer = false,
    this.buttons = const ['Previous', 'Play/Pause', 'Next'],
    this.dominantColor,
  });

  @override
  Widget build(BuildContext context) {
    final mediaItem = audioHandler.mediaItem.value!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: buttons.map<Widget>((e) {
        switch (e) {
          // case 'Like':
          //   return !online
          //       ? const SizedBox()
          //       : LikeButton(
          //           mediaItem: mediaItem,
          //           size: 22.0,
          //         );
          case 'Previous':
            return StreamBuilder<QueueState>(
              stream: audioHandler.queueState,
              builder: (context, snapshot) {
                final queueState = snapshot.data;
                return IconButton(
                  disabledColor: AppColors.subTitleColor,
                  icon: const Icon(Icons.skip_previous_rounded),
                  iconSize: minelayer ? 24.0 : 45.0,
                  tooltip: 'Previous',
                  color: dominantColor ?? Theme.of(context).iconTheme.color,
                  onPressed: queueState?.hasPrevious ?? true ? audioHandler.skipToPrevious : null,
                );
              },
            );
          case 'Play/Pause':
            return SizedBox(
              height: minelayer ? 40.0 : 65.0,
              width: minelayer ? 40.0 : 65.0,
              child: StreamBuilder<PlaybackState>(
                stream: audioHandler.playbackState,
                builder: (context, snapshot) {
                  final playbackState = snapshot.data;
                  final processingState = playbackState?.processingState;
                  final playing = playbackState?.playing ?? true;
                  return Stack(
                    children: [
                      if (processingState == AudioProcessingState.loading ||
                          processingState == AudioProcessingState.buffering)
                        Center(
                          child: SizedBox(
                            height: minelayer ? 40.0 : 65.0,
                            width: minelayer ? 40.0 : 65.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).iconTheme.color!,
                              ),
                            ),
                          ),
                        ),
                      if (minelayer)
                        Center(
                          child: playing
                              ? IconButton(
                                  tooltip: 'Pause',
                                  onPressed: audioHandler.pause,
                                  icon: const Icon(
                                    Icons.pause_rounded,
                                  ),
                                  color: AppColors.subTitleColor)
                              : IconButton(
                                  tooltip: 'Play',
                                  onPressed: audioHandler.play,
                                  icon: const Icon(
                                    Icons.play_arrow_rounded,
                                  ),
                                  color: Theme.of(context).iconTheme.color,
                                ),
                        )
                      else
                        Center(
                          child: SizedBox(
                            height: 59,
                            width: 59,
                            child: Center(
                              child: playing
                                  ? FloatingActionButton(
                                      elevation: 10,
                                      tooltip: 'Pause',
                                      backgroundColor: Colors.white,
                                      onPressed: audioHandler.pause,
                                      child: const Icon(
                                        Icons.pause_rounded,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                    )
                                  : FloatingActionButton(
                                      elevation: 10,
                                      tooltip: 'Play',
                                      backgroundColor: Colors.white,
                                      onPressed: audioHandler.play,
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            );
          case 'Next':
            return StreamBuilder<QueueState>(
              stream: audioHandler.queueState,
              builder: (context, snapshot) {
                final queueState = snapshot.data;
                return IconButton(
                  disabledColor: AppColors.subTitleColor,
                  icon: const Icon(Icons.skip_next_rounded),
                  iconSize: minelayer ? 24.0 : 45.0,
                  tooltip: 'Skip',
                  color: dominantColor ?? Theme.of(context).iconTheme.color,
                  onPressed: queueState?.hasNext ?? true ? audioHandler.skipToNext : null,
                );
              },
            );
          // case 'Download':
          //   return !online
          //       ? const SizedBox()
          //       : DownloadButton(
          //           size: 20.0,
          //           icon: 'download',
          //           data: MediaItemConverter.mediaItemtoMap(mediaItem),
          //         );
          default:
            break;
        }
        return const SizedBox();
      }).toList(),
    );
  }
}
