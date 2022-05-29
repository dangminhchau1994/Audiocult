import 'package:audio_cult/app/data_source/models/universal_search/bottom_subtitle_universal_search_item.dart';
import 'package:audio_cult/app/data_source/models/universal_search/no_subtitle_universal_search_item.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/bottom_subtitle_search_result_list_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/no_subtitle_search_result_list_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/recent_search_list_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_widget/universal_search_wrapper.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

class UniversalSearchAllScreen extends StatefulWidget {
  const UniversalSearchAllScreen({Key? key}) : super(key: key);

  @override
  State<UniversalSearchAllScreen> createState() => UniversalSearchAllScreenState();
}

class UniversalSearchAllScreenState extends State<UniversalSearchAllScreen> {
  @override
  Widget build(BuildContext context) {
    return UniversalSearchWrapper([
      _recentSearchWidget(),
      const SizedBox(height: 12),
      _resultOfMusicListView(),
      const SizedBox(height: 12),
      _resultOfEventListView(),
      const SizedBox(height: 12),
      _resultOfPeopleListView(),
      const SizedBox(height: 12),
      _resultOfPostListView(),
      const SizedBox(height: 12),
      _resultOfMessageListView(),
      const SizedBox(height: 12),
    ]);
  }

  Widget _recentSearchWidget() {
    return const RecentSearchListWidget(
      title: null,
      recentKeywords: ['recentKeywords'],
    );
  }

  Widget _resultOfMusicListView() {
    return BottomSubtitleSearchResultListWidget(
      itemOnSelect: (item) {
        // TODO: handle item on tap
      },
      headerTitle: context.l10n.t_music,
      results: [
        BottomSubtitleUniversalSearchItem(
          imageUrl:
              'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
          title: 'Music title',
          subtitle: 'ManMadeMan - 2:37',
        )
      ],
    );
  }

  Widget _resultOfEventListView() {
    return BottomSubtitleSearchResultListWidget(
      headerTitle: context.l10n.t_events,
      results: [
        BottomSubtitleUniversalSearchItem(
          imageUrl:
              'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
          title: 'Event title',
          subtitle: 'ManMadeMan - 2:37',
        )
      ],
    );
  }

  Widget _resultOfPeopleListView() {
    return NoSubtitleSearchResultListWidget(
      headerTitle: context.l10n.t_people,
      results: [
        NoSubtitleUniversalSearchItem(
          imageUrl:
              'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
          title: 'People title',
        ),
        NoSubtitleUniversalSearchItem(
          imageUrl:
              'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
          title: 'People title',
        ),
        NoSubtitleUniversalSearchItem(
          imageUrl:
              'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
          title: 'People title',
        )
      ],
    );
  }

  Widget _resultOfPostListView() {
    return NoSubtitleSearchResultListWidget(
      headerTitle: context.l10n.t_post,
      results: [
        NoSubtitleUniversalSearchItem(
          imageUrl:
              'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
          title: 'People title',
        )
      ],
    );
  }

  Widget _resultOfMessageListView() {
    return NoSubtitleSearchResultListWidget(
      headerTitle: context.l10n.t_message,
      results: [
        NoSubtitleUniversalSearchItem(
          imageUrl:
              'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
          title: 'People title',
        )
      ],
    );
  }
}
