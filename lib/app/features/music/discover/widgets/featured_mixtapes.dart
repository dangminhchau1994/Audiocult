import 'package:audio_cult/app/data_source/models/responses/fake_song.dart';
import 'package:audio_cult/app/features/music/discover/widgets/page_song.dart';
import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:flutter/material.dart';

class FeatureMixtapes extends StatelessWidget {
  const FeatureMixtapes({
    Key? key,
    this.onPageChange,
    this.songs,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final List<FakeSong>? songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Feature Mixtapes',
          ),
          const SizedBox(
            height: 16,
          ),
          // PageSong(
          //   onPageChange: onPageChange,
          //   songs: songs,
          // ),
        ],
      ),
    );
  }
}
