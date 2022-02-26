import 'package:audio_cult/app/data_source/models/responses/fake_song.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({
    Key? key,
    this.album,
  }) : super(key: key);

  final FakeSong? album;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          width: 180,
          height: 180,
          imageUrl: album?.imageUrl ?? '',
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
                album?.title ?? '',
                overflow: TextOverflow.ellipsis,
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      fontSize: 16,
                    ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              album?.date ?? '',
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 16,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
