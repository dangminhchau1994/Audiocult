import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/app_colors.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({
    Key? key,
    this.album,
    this.playlist,
    this.imageSize = 180,
  }) : super(key: key);

  final Album? album;
  final PlaylistResponse? playlist;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImageNetWork(
          width: imageSize,
          height: imageSize,
          imagePath: playlist != null ? playlist?.imagePath ?? '' : album?.imagePath ?? '',
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                playlist != null ? playlist?.title ?? '' : album?.name ?? '',
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
                  playlist != null ? playlist?.userName ?? '' : album?.fullName ?? '',
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
                  playlist != null
                      ? '${playlist?.countSongs.toString()} songs'
                      : DateTimeUtils.formatyMMMMd(int.parse(album?.timeStamp ?? '')),
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
    );
  }
}
