import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:audio_cult/w_components/menus/common_popup_menu.dart';
import 'package:flutter/material.dart';
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
    this.currency,
    this.removeFromPlaylist,
  }) : super(key: key);

  final Song? song;
  final bool? hasMenu;
  final double? imageSize;
  final bool? fromDetail;
  final List<Song>? songs;
  final int? index;
  final Widget? customizeMenu;
  final String? currency;
  final Function()? removeFromPlaylist;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: () async {
        await Navigator.pushNamed(
          context,
          AppRoute.routePlayerScreen,
          arguments: PlayerScreen.createArguments(
            listSong: songs ?? [],
            index: index!,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 20,
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
                            song?.artistUser?.fullName ?? 'N/A',
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
                            song?.duration != null && song?.duration?.isNotEmpty == true
                                ? formatTime(Duration(seconds: int.tryParse(song!.duration!)!))
                                : 'N/A',
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: AppColors.subTitleColor,
                                  fontSize: 16,
                                ),
                          ),
                          ..._priceWidgets(context),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            if (hasMenu!)
              Expanded(
                flex: 2,
                child: CommonPopupMenu(
                  items: fromDetail!
                      ? GlobalConstants.menuItemsWithOutDetail(context)
                      : GlobalConstants.menuItemsWithDetail(context),
                  onSelected: (selected) {
                    switch (selected) {
                      case 0:
                        fromDetail!
                            ? removeFromPlaylist!()
                            : Navigator.pushNamed(
                                context,
                                AppRoute.routeLibrary,
                                arguments: {
                                  'has_app_bar': true,
                                  'song_id': song?.songId,
                                },
                              );
                        break;
                      case 1:
                        ToastUtility.showPending(context: context, message: context.localize.t_feature_development);
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
                ),
              )
            else
              const SizedBox(),
            if (customizeMenu != null) customizeMenu! else const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  List<Widget> _priceWidgets(BuildContext context) {
    if (song?.cost == null || num.tryParse(song?.cost ?? '') == null || num.tryParse(song?.cost ?? '') == 0) {
      return [Container()];
    }
    return [
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
        "${song?.cost ?? ' '} ${currency ?? ''}",
        overflow: TextOverflow.ellipsis,
        style: context.bodyTextPrimaryStyle()!.copyWith(
              color: AppColors.subTitleColor,
              fontSize: 16,
            ),
      )
    ];
  }
}
