import 'package:audio_cult/app/data_source/models/universal_search/bottom_subtitle_universal_search_item.dart';
import 'package:audio_cult/app/data_source/models/universal_search/no_subtitle_universal_search_item.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/bottom_subtitle_search_result_list_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/no_subtitle_search_result_list_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/recent_search_list_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/universal_search_wrapper.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

class UniversalSearchMusicScreen extends StatefulWidget {
  const UniversalSearchMusicScreen({Key? key}) : super(key: key);

  @override
  State<UniversalSearchMusicScreen> createState() => UniversalSearchMusicScreenState();
}

class UniversalSearchMusicScreenState extends State<UniversalSearchMusicScreen> {
  @override
  Widget build(BuildContext context) {
    return UniversalSearchWrapper([
      _recentSearchWidget(),
      const SizedBox(height: 12),
      _musicResultsListWidget(),
    ]);
  }

  Widget _musicResultsListWidget() {
    return BottomSubtitleSearchResultListWidget(
      headerTitle: context.l10n.t_music,
      results: [
        BottomSubtitleUniversalSearchItem(
            imageUrl:
                'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
            title: 'Song Name',
            subtitle: 'JAN 28-30, 2021'),
        BottomSubtitleUniversalSearchItem(
            imageUrl:
                'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
            title: 'Song Name',
            subtitle: 'JAN 28-30, 2021'),
        BottomSubtitleUniversalSearchItem(
            imageUrl:
                'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
            title: 'Song Name',
            subtitle: 'JAN 28-30, 2021'),
      ],
    );
  }

  Widget _recentSearchWidget() {
    return const RecentSearchListWidget(
      title: null,
      recentKeywords: ['recentKeywords'],
    );
  }
}
