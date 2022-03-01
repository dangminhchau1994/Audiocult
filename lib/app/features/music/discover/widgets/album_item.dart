import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({
    Key? key,
    this.album,
  }) : super(key: key);

  final Album? album;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          width: 180,
          height: 180,
          imageUrl: album?.imagePath ?? '',
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
          height: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                album?.name ?? '',
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
                  album?.fullName ?? '',
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
                  DateTimeUtils.formatyMMMMd(int.parse(album?.timeStamp ?? '')),
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
