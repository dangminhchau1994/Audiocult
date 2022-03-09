import 'package:audio_cult/app/features/audio_player/queue_state.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class AudioPlayerHandler implements AudioHandler {
  Stream<QueueState> get queueState;
  Future<void> moveQueueItem(int currentIndex, int newIndex);
  ValueStream<double> get volume;
  Future<void> setVolume(double volume);
  ValueStream<double> get speed;
}

class NowPlayingStream extends StatelessWidget {
  final AudioPlayerHandler audioHandler;
  final ScrollController? scrollController;
  final bool head;
  final double headHeight;

  const NowPlayingStream({
    required this.audioHandler,
    this.scrollController,
    this.head = false,
    this.headHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QueueState>(
      stream: audioHandler.queueState,
      builder: (context, snapshot) {
        final queueState = snapshot.data ?? QueueState.empty;
        final queue = queueState.queue;

        return ReorderableListView.builder(
          header: SizedBox(
            height: head ? headHeight : 0,
          ),
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex--;
            }
            audioHandler.moveQueueItem(oldIndex, newIndex);
          },
          scrollController: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          itemCount: queue.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(queue[index].id),
              direction: index == queueState.queueIndex ? DismissDirection.none : DismissDirection.horizontal,
              onDismissed: (dir) {
                audioHandler.removeQueueItemAt(index);
              },
              child: ListTileTheme(
                selectedColor: Theme.of(context).colorScheme.secondary,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 16.0, right: 10.0),
                  selected: index == queueState.queueIndex,
                  trailing: index == queueState.queueIndex
                      ? IconButton(
                          icon: const Icon(
                            Icons.bar_chart_rounded,
                          ),
                          tooltip: 'Play',
                          onPressed: () {},
                        )
                      : queue[index].extras!['url'].toString().startsWith('http')
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // LikeButton(
                                //   mediaItem: queue[index],
                                // ),
                                // DownloadButton(
                                //   icon: 'download',
                                //   size: 25.0,
                                //   data: {
                                //     'id': queue[index].id,
                                //     'artist': queue[index].artist.toString(),
                                //     'album': queue[index].album.toString(),
                                //     'image': queue[index].artUri.toString(),
                                //     'duration': queue[index]
                                //         .duration!
                                //         .inSeconds
                                //         .toString(),
                                //     'title': queue[index].title,
                                //     'url':
                                //         queue[index].extras?['url'].toString(),
                                //     'year':
                                //         queue[index].extras?['year'].toString(),
                                //     'language': queue[index]
                                //         .extras?['language']
                                //         .toString(),
                                //     'genre': queue[index].genre?.toString(),
                                //     '320kbps': queue[index].extras?['320kbps'],
                                //     'has_lyrics':
                                //         queue[index].extras?['has_lyrics'],
                                //     'release_date':
                                //         queue[index].extras?['release_date'],
                                //     'album_id':
                                //         queue[index].extras?['album_id'],
                                //     'subtitle':
                                //         queue[index].extras?['subtitle'],
                                //     'perma_url':
                                //         queue[index].extras?['perma_url'],
                                //   },
                                // )
                              ],
                            )
                          : const SizedBox(),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (queue[index].extras?['addedByAutoplay'] as bool? ?? false)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    "Add by",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 5.0,
                                    ),
                                  ),
                                ),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    'Auto Play',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 8.0,
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: (queue[index].artUri == null)
                            ? const SizedBox.square(
                                dimension: 50,
                                child: Image(
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                  title: Text(
                    queue[index].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: index == queueState.queueIndex ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    queue[index].artist!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    audioHandler.skipToQueueItem(index);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
