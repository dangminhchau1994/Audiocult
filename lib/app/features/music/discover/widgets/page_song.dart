import 'package:audio_cult/app/data_source/models/responses/fake_song.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:flutter/material.dart';

class PageSong extends StatelessWidget {
  const PageSong({
    Key? key,
    this.onPageChange,
    this.songs,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final List<FakeSong>? songs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196,
      child: PageView.builder(
        onPageChanged: onPageChange,
        itemCount: songs?.length ?? 0,
        itemBuilder: (context, index) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs?.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return SongItem(
                song: songs?[index],
                onMenuClick: () {},
              );
            },
          );
        },
      ),
    );
  }
}
