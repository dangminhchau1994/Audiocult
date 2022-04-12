import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/features/music/playlist_dialog.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:audio_cult/w_components/menus/common_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../data_source/models/responses/song/song_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';
import '../../../player_widgets/player_screen.dart';

class SongItem extends StatelessWidget {
  const SongItem({
    Key? key,
    this.song,
    this.imageSize = 40,
    this.hasMenu = true,
    this.fromDetail = false,
    this.songs,
    this.index,
    this.customizeMenu,
  }) : super(key: key);

  final Song? song;
  final bool? hasMenu;
  final double? imageSize;
  final bool? fromDetail;
  final List<Song>? songs;
  final int? index;
  final Widget? customizeMenu;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          AppRoute.routePlayerScreen,
          arguments: PlayerScreen.createArguments(
            listSong: songs!,
            index: index!,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CommonImageNetWork(
                  width: imageSize,
                  height: imageSize,
                  imagePath: song?.imagePath ?? '',
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        song?.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          song?.artistUser?.userName ?? 'N/A',
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.subTitleColor,
                                fontSize: 16,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          fromDetail!
                              ? DateTimeUtils.formatyMMMMd(int.parse(song?.timeStamp ?? ''))
                              : DateTimeUtils.formatCommonDate('hh:mm', int.parse(song?.timeStamp ?? '')),
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.subTitleColor,
                                fontSize: 16,
                              ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          if (hasMenu!)
            CommonPopupMenu(
              items: fromDetail!
                  ? GlobalConstants.menuItemsWithOutDetail(context)
                  : GlobalConstants.menuItemsWithDetail(context),
              onSelected: (selected) {
                switch (selected) {
                  case 0:
                    showMaterialModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return PlayListDialog(
                          songId: song?.songId,
                        );
                      },
                    );
                    break;
                  case 1:
                    break;
                  case 2:
                    Navigator.pushNamed(
                      context,
                      AppRoute.routeDetailSong,
                      arguments: {'song_id': song!.songId},
                    );
                    break;
                  default:
                }
              },
            )
          else
            const SizedBox(),
          if (customizeMenu != null) customizeMenu! else const SizedBox.shrink()
        ],
      ),
    );
  }
}
