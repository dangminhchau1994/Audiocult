import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
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
  static const String reportComment = 'comment';
  static const String reportVideo = 'v';
  static const String reportPlaylist = 'advancedmusic_playlist';
  static const String reportSong = 'music_song';
  static const String reportAlbum = 'music_album';
  static const String reportPhoto = 'photo';
  static const String reportFeed = 'feed';
  static List<Pair<Pair<int, Widget>, String>>? _myAlbumMenuPairs;

  static const int loadMoreItem = 10;

  static String imageUrl(String path) {
    return url + path;
  }

  static List<SelectMenuModel> listPrivacy(
    BuildContext context, {
    bool autoFirstOption = true,
  }) {
    return [
      SelectMenuModel(
        id: 0,
        title: context.localize.t_everyone,
        isSelected: autoFirstOption,
        icon: Image.asset(
          AppAssets.icPublic,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 1,
        title: context.localize.t_subscriptions,
        icon: Image.asset(
          AppAssets.icSubscription,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 2,
        title: context.localize.t_friends_of_friends,
        icon: Image.asset(
          AppAssets.icFriends,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 3,
        title: context.localize.t_only_me,
        icon: Image.asset(
          AppAssets.icLock,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 4,
        title: context.localize.t_customize,
        icon: Image.asset(
          AppAssets.icSetting,
          width: 24,
        ),
      ),
    ];
  }

  static List<Pair<Pair<int, Widget>, String>>? menuMyAlbum(BuildContext context) {
    return _myAlbumMenuPairs ??= [
      Pair(
        Pair(
          1,
          SvgPicture.asset(AppAssets.edit),
        ),
        context.localize.t_edit,
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
          context.localize.t_feature_song,
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
          context.localize.t_song_of_the_day,
        ),
      Pair(
        Pair(
          4,
          SvgPicture.asset(AppAssets.addPlaylistIcon),
        ),
        context.localize.t_add_playlist,
      ),
      Pair(
        Pair(
          5,
          Image.asset(
            AppAssets.icDelete,
            width: 24,
          ),
        ),
        context.localize.t_delete,
      ),
    ];
  }

  static List<SelectMenuModel> getSelectedMenu(BuildContext context) {
    return [
      SelectMenuModel(id: 1, title: context.localize.t_attending),
      SelectMenuModel(id: 2, title: context.localize.t_maybe_attending),
      SelectMenuModel(id: 3, title: context.localize.t_not_attending),
    ];
  }

  static List<Map<String, String>> getWhenList(BuildContext context) {
    return [
      {context.localize.t_all_time: 'all-time'},
      {context.localize.t_this_month: 'this-month'},
      {context.localize.t_this_week: 'this-week'},
      {context.localize.t_today: 'today'},
      {context.localize.t_upcoming: 'upcoming'},
    ];
  }

  static List<Map<String, String>> getDistanceList(BuildContext context) {
    return [
      {'50 ${context.localize.t_miles}': '50'},
      {'100 ${context.localize.t_miles}': '100'},
      {'200 ${context.localize.t_miles}': '200'},
      {'300 ${context.localize.t_miles}': '300'},
    ];
  }

  static List<PopupMenuEntry<int>> menuItemsWithOutDetail(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Text(
          context.localize.t_remove_from_playlist,
        ),
      ),
      // PopupMenuItem<int>(
      //   value: 1,
      //   child: Row(
      //     children: [
      //       SvgPicture.asset(
      //         AppAssets.shareIcon,
      //         width: 16,
      //         height: 16,
      //       ),
      //       const SizedBox(
      //         width: 10,
      //       ),
      //       Text(
      //         context.localize.t_share,
      //       )
      //     ],
      //   ),
      // ),
    ];
  }

  static List<PopupMenuEntry<int>> menuProfile(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            const Icon(
              Icons.block,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.localize.t_block_user,
            )
          ],
        ),
      ),
    ];
  }

  static List<PopupMenuEntry<int>> menuDetail(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            const Icon(
              Icons.flag,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.localize.t_report,
            )
          ],
        ),
      ),
      // PopupMenuItem<int>(
      //   value: 0,
      //   child: Row(
      //     children: [
      //       const Icon(
      //         Icons.edit,
      //       ),
      //       const SizedBox(
      //         width: 10,
      //       ),
      //       Text(
      //         context.localize.t_edit,
      //       )
      //     ],
      //   ),
      // ),
    ];
  }

  static List<PopupMenuEntry<int>> menuFeedSubcriberItem(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Row(
          children: [
            const Icon(
              Icons.flag,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.localize.t_report,
            )
          ],
        ),
      ),
    ];
  }

  static List<PopupMenuEntry<int>> menuFeedUserItem(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 1,
        child: Row(
          children: [
            const Icon(
              Icons.delete,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              context.localize.t_delete,
            )
          ],
        ),
      ),
      // PopupMenuItem<int>(
      //   value: 2,
      //   child: Row(
      //     children: [
      //       const Icon(
      //         Icons.flag_sharp,
      //       ),
      //       const SizedBox(
      //         width: 10,
      //       ),
      //       Text(
      //         context.localize.t_save,
      //       )
      //     ],
      //   ),
      // ),
    ];
  }

  static List<PopupMenuEntry<int>> menuModify(BuildContext context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Text(
          context.localize.t_delete,
        ),
      ),
      // PopupMenuItem<int>(
      //   value: 1,
      //   child: Text(
      //     context.localize.t_edit,
      //   ),
      // ),
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
              context.localize.t_add_playlist,
            )
          ],
        ),
      ),
      // PopupMenuItem<int>(
      //   value: 1,
      //   child: Row(
      //     children: [
      //       SvgPicture.asset(
      //         AppAssets.shareIcon,
      //         width: 16,
      //         height: 16,
      //       ),
      //       const SizedBox(
      //         width: 10,
      //       ),
      //       Text(
      //         context.localize.t_share,
      //       )
      //     ],
      //   ),
      // ),
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
              context.localize.t_song_detail,
            )
          ],
        ),
      ),
    ];
  }
}
