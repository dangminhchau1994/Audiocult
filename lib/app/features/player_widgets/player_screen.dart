import 'dart:io';

import 'package:audio_cult/app/features/player_widgets/artwork_widget.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data_source/models/responses/song/song_response.dart';
import '../../injections.dart';
import '../audio_player/audio_player.dart';
import 'name_n_control.dart';

class PlayerScreen extends StatefulWidget {
  final Map<String, dynamic> params;
  const PlayerScreen({Key? key, required this.params}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();

  static Map<String, dynamic> createArguments({
    required List<Song> listSong,
    required int index,
    bool fromMini = false,
    MediaItem? mediaItem,
  }) =>
      {
        'listSong': listSong,
        'index': index,
        'from_mini': fromMini,
      };
}

class _PlayerScreenState extends State<PlayerScreen> {
  List<MediaItem> globalQueue = [];
  int globalIndex = 0;
  final audioHandler = locator.get<AudioPlayerHandler>();
  List<Song> response = [];
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final PanelController _panelController = PanelController();
  bool fromMiniplayer = false;

  @override
  void initState() {
    super.initState();
    globalIndex = widget.params['index'] as int;
    response = widget.params['listSong'] as List<Song>;
    fromMiniplayer = widget.params['from_mini'] as bool;
    if (!fromMiniplayer) {
      if (!Platform.isAndroid) {
        // Don't know why but it fixes the playback issue with iOS Side
        audioHandler.stop();
      }
      playMusic();
    }
  }

  void playMusic() async {
    mapperList();
    await audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    await audioHandler.updateQueue(globalQueue);
    await audioHandler.skipToQueueItem(globalIndex);
    await audioHandler.play();
    await audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
  }

  void mapperList() {
    globalQueue.addAll(
      response.map(
        (element) => MediaItem(
          id: element.songId.toString(),
          title: element.title.toString(),
          album: element.albumName ?? 'N/A',
          artist: element.artistUser?.fullName ?? 'N/A',
          duration: Duration(seconds: int.tryParse(element.duration ?? '0')!),
          artUri: Uri.parse(element.image400.toString()),
          displayTitle: element.artistUser?.userId,
          displaySubtitle: element.albumId.toString(),
          extras: {
            'url': element.songPath.toString(),
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.down,
      background: Container(color: Colors.transparent),
      key: const Key('playScreen'),
      onDismissed: (direction) {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          backgroundColor: AppColors.mainColor,
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_rounded),
              ),
            )
          ],
        ),
        body: StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, snapshot) {
            final mediaItem = snapshot.data;
            if (mediaItem == null) return const SizedBox();
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: [
                    ArtWorkWidget(
                      cardKey: cardKey,
                      mediaItem: mediaItem,
                      width: constraints.maxWidth,
                      audioHandler: audioHandler,
                    ),
                    // title and controls
                    Expanded(
                      child: NameNControls(
                        mediaItem: mediaItem,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight - (constraints.maxWidth * 0.85),
                        panelController: _panelController,
                        audioHandler: audioHandler,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
