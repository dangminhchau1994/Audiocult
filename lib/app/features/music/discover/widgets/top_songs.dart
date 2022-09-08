import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_page.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class TopSongs extends StatelessWidget {
  const TopSongs({
    Key? key,
    this.onPageChange,
    this.pageController,
    this.isTopSong,
    this.onRetry,
    this.onShowAll,
    this.onNextPage,
    this.itemCount,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final Function()? onRetry;
  final PageController? pageController;
  final bool? isTopSong;
  final int? itemCount;
  final Function(int index)? onNextPage;
  final Function()? onShowAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: context.localize.t_top_song,
            onShowAll: onShowAll,
          ),
          const SizedBox(
            height: 16,
          ),
          SongPage(
            onNextPage: onNextPage,
            itemCount: itemCount,
            onPageChange: onPageChange,
            pageController: pageController,
            onRetry: onRetry,
            isTopSong: isTopSong,
          ),
        ],
      ),
    );
  }
}
