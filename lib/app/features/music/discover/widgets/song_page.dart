import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';

import '../../../../data_source/models/responses/song/song_response.dart';

class SongPage extends StatelessWidget {
  const SongPage({
    Key? key,
    this.onPageChange,
    this.onRetry,
    this.isTopSong,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final Function()? onRetry;
  final bool? isTopSong;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196,
      child: PageView.builder(
        onPageChanged: onPageChange,
        itemCount: isTopSong! ? 3 : 2,
        itemBuilder: (context, index) {
          return StreamBuilder<BlocState<List<Song>>>(
            initialData: const BlocState.loading(),
            stream: isTopSong!
                ? locator.get<DiscoverBloc>().getTopSongsStream
                : locator.get<DiscoverBloc>().getMixTapSongsStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (data) {
                  final songs = data as List<Song>;

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: songs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return SongItem(
                        song: songs[index],
                        onMenuClick: () {},
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
                    onRetryTap: onRetry,
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