import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_page.dart';
import 'package:flutter/material.dart';

class FeatureMixtapes extends StatelessWidget {
  const FeatureMixtapes({
    Key? key,
    this.onPageChange,
    this.onRetry,
    this.pageController,
    this.isTopSong,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final Function()? onRetry;
  final PageController? pageController;
  final bool? isTopSong;

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
          SongPage(
            onPageChange: onPageChange,
            pageController: pageController,
            isTopSong: isTopSong,
            onRetry: onRetry,
          )
        ],
      ),
    );
  }
}
