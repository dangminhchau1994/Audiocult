import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/pair.dart';
import '../features/main/main_bloc.dart';
import '../injections.dart';
import '../utils/constants/app_assets.dart';

class GlobalConstants {
  static const String url = 'https://staging-media.audiocult.net/file/pic/music/';
  static const String visitorNew = 'visitor_new';
  static const String commentMusic = 'comment_music_song';
  static const String commentEvent = 'comment_event';
  static const String commentAlbum = 'comment_music_album';

  static const int loadMoreItem = 10;

  static String imageUrl(String path) {
    return url + path;
  }

  static List<SelectMenuModel> listPrivacy = [
    SelectMenuModel(
      id: 1,
      title: 'Everyone',
      isSelected: true,
      icon: Image.asset(
        AppAssets.icPublic,
        width: 24,
      ),
    ),
    SelectMenuModel(
      id: 2,
      title: 'Subscriptions',
      icon: Image.asset(
        AppAssets.icSubscription,
        width: 24,
      ),
    ),
    SelectMenuModel(
      id: 3,
      title: 'Friends of Friends',
      icon: Image.asset(
        AppAssets.icFriends,
        width: 24,
      ),
    ),
    SelectMenuModel(
      id: 4,
      title: 'Only me',
      icon: Image.asset(
        AppAssets.icLock,
        width: 24,
      ),
    ),
    SelectMenuModel(
      id: 5,
      title: 'Customize',
      icon: Image.asset(
        AppAssets.icSetting,
        width: 24,
      ),
    ),
  ];

  static List<Pair<Pair<int, Widget>, String>>? menuMyAlbum(BuildContext context) {
    return [
      Pair(
        Pair(
          1,
          SvgPicture.asset(AppAssets.edit),
        ),
        context.l10n.t_edit,
      ),
      if (locator.get<MainBloc>().profileData!.userId == '1')
        Pair(
          Pair(
            2,
            Image.asset(
              AppAssets.icFeatureSong,
              width: 24,
            ),
          ),
          context.l10n.t_feature_song,
        ),
      if (locator.get<MainBloc>().profileData!.userId == '1')
        Pair(
          Pair(
            3,
            Image.asset(
              AppAssets.icMusicNote,
              width: 24,
            ),
          ),
          context.l10n.t_song_of_the_day,
        ),
      Pair(
        Pair(
          4,
          SvgPicture.asset(AppAssets.addPlaylistIcon),
        ),
        context.l10n.t_add_playlist,
      ),
      Pair(
        Pair(
          5,
          Image.asset(
            AppAssets.icDelete,
            width: 24,
          ),
        ),
        context.l10n.t_delete,
      ),
    ];
  }

  static List<SelectMenuModel> getSelectedMenu(BuildContext context) {
    return [
      SelectMenuModel(id: 1, title: context.l10n.t_attending),
      SelectMenuModel(id: 2, title: context.l10n.t_maybe_attending),
    ];
  }

  static List<Map<String, String>> getWhenList() {
    return [
      {'All time': 'all-time'},
      {'This month': 'this-month'},
      {'This week': 'this-week'},
      {'Today': 'today'},
      {'Upcoming': 'upcoming'},
    ];
  }

  static List<Map<String, String>> getDistanceList() {
    return [
      {'50 Miles': '50'},
      {'100 Miles': '100'},
      {'200 Miles': '200'},
      {'300 Miles': '300'},
    ];
  }

  static List<PopupMenuEntry<int>> menuItemsWithOutDetail(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.addPlaylistIcon,
              width: 14,
              height: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.l10n.t_add_playlist,
            )
          ],
        ),
      ),
      const PopupMenuDivider(),
      PopupMenuItem<int>(
        value: 1,
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.shareIcon,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.l10n.t_share,
            )
          ],
        ),
      ),
    ];
  }

  static List<PopupMenuEntry<int>> menuFeedItem(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            const Icon(
              Icons.edit,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.l10n.t_edit,
            )
          ],
        ),
      ),
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            const Icon(
              Icons.delete,
            ),
            const SizedBox(
             width: 10,
            ),
            Text(
              context.l10n.t_delete,
            )
          ],
        ),
      ),
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            const Icon(
              Icons.flag_sharp,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.l10n.t_save,
            )
          ],
        ),
      ),
    ];
  }

  static List<PopupMenuEntry<int>> menuItemsWithDetail(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.addPlaylistIcon,
              width: 14,
              height: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.l10n.t_add_playlist,
            )
          ],
        ),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.shareIcon,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.l10n.t_share,
            )
          ],
        ),
      ),
      PopupMenuItem<int>(
        value: 2,
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.songDetailIcon,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.l10n.t_song_detail,
            )
          ],
        ),
      ),
    ];
  }
}
