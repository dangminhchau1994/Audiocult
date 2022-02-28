import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_page.dart';
import 'package:flutter/material.dart';

class TopSongs extends StatelessWidget {
  const TopSongs({
    Key? key,
    this.onPageChange,
    this.isTopSong,
    this.onRetry,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final Function()? onRetry;
  final bool? isTopSong;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Top Songs',
          ),
          const SizedBox(
            height: 16,
          ),
          SongPage(
            onPageChange: onPageChange,
            isTopSong: isTopSong,
            onRetry: onRetry,
          ),
        ],
      ),
    );
  }
}
