import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants/app_assets.dart';

class GlobalConstants {
  static const String url = 'https://staging-media.audiocult.net/file/pic/music/';

  static const int loadMoreItem = 10;

  static String imageUrl(String path) {
    return url + path;
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
              style: const TextStyle(
                fontSize: 12,
              ),
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
              style: const TextStyle(
                fontSize: 12,
              ),
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
              style: const TextStyle(
                fontSize: 12,
              ),
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
              style: const TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
      const PopupMenuDivider(),
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
              style: const TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    ];
  }
}
