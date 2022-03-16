import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../../di/bloc_locator.dart';
import '../../../../data_source/models/responses/song/song_response.dart';
import '../../../audio_player/audio_player.dart';

class SongPage extends StatefulWidget {
  const SongPage({
    Key? key,
    this.onPageChange,
    this.pageController,
    this.onRetry,
    this.isTopSong,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final Function()? onRetry;
  final bool? isTopSong;
  final PageController? pageController;

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  List<MediaItem> globalQueue = [];

  final audioHandler = locator.get<AudioPlayerHandler>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196,
      child: PageView.builder(
        onPageChanged: widget.onPageChange,
        controller: widget.pageController,
        itemCount: widget.isTopSong! ? 3 : 2,
        itemBuilder: (context, index) {
          return StreamBuilder<BlocState<List<Song>>>(
            initialData: const BlocState.loading(),
            stream: widget.isTopSong!
                ? getIt.get<DiscoverBloc>().getTopSongsStream
                : getIt.get<DiscoverBloc>().getMixTapSongsStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (data) {
                  final songs = data as List<Song>;
                  songs.forEach((element) {
                    globalQueue.add(
                      MediaItem(
                        id: element.songId.toString(),
                        title: element.title.toString(),
                        album: element.artistUser?.userName ?? 'N/A',
                        artist: element.artistUser?.userName ?? 'N/A',
                        artUri: Uri.parse(element.imagePath.toString()),
                        extras: {
                          'url': element.songPath.toString(),
                        },
                      ),
                    );
                  });
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: songs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return WButtonInkwell(
                        onPressed: () async {
                          await audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
                          await audioHandler.updateQueue(globalQueue);
                          await audioHandler.skipToQueueItem(index);
                          await audioHandler.play();
                          await audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
                        },
                        child: SongItem(
                          song: songs[index],
                          hasMenu: true,
                        ),
                      );
                    },
                  );
                },
                loading: () {
                  return const Center(child: LoadingWidget());
                },
                error: (error) {
                  return ErrorSectionWidget(
                    errorMessage: error,
                    onRetryTap: widget.onRetry,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
