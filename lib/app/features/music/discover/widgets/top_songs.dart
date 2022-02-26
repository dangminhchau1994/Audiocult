import 'package:audio_cult/app/features/music/discover/widgets/page_song.dart';
import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:flutter/material.dart';

class TopSongs extends StatelessWidget {
  const TopSongs({
    Key? key,
    this.controller,
    this.onPageChange,
  }) : super(key: key);

  final ScrollController? controller;
  final Function(int index)? onPageChange;

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
          PageSong(
            onPageChange: onPageChange,
          ),
        ],
      ),
    );
  }
}
