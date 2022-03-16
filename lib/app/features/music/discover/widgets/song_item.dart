import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import '../../../../data_source/models/responses/song/song_response.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';

class SongItem extends StatelessWidget {
  const SongItem({
    Key? key,
    this.song,
    this.imageSize = 40,
    this.hasMenu,
    this.fromDetail = false,
  }) : super(key: key);

  final Song? song;
  final bool? hasMenu;
  final double? imageSize;
  final bool? fromDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                width: imageSize,
                height: imageSize,
                imageUrl: song?.imagePath ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryButtonColor,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
          if (hasMenu!)
            SvgPicture.asset(
              AppAssets.horizIcon,
              width: 16,
              height: 16,
            )
          else
            const SizedBox()
        ],
      ),
    );
  }
}
