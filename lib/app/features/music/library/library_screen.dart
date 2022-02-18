import 'package:audio_cult/app/data_source/models/responses/fake_song.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({Key? key}) : super(key: key);

  final songs = FakeSong.generateSongs();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
        vertical: kVerticalSpacing,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: songs.length,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          return SongItem(
            song: songs[index],
            imageSize: 64,
          );
        },
      ),
    );
  }
}
