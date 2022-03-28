import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../data_source/models/responses/album/album_response.dart';
import '../../../data_source/models/responses/playlist/playlist_response.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/datetime/date_time_utils.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    this.album,
    this.playlist,
  }) : super(key: key);

  final Album? album;
  final PlaylistResponse? playlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          width: 64,
          height: 64,
          imageUrl: playlist != null ? playlist?.imagePath ?? '' : album?.imagePath ?? '',
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
          width: 16,
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
