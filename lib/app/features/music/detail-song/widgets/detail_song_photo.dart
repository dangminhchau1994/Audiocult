import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class DetailPhotoSong extends StatelessWidget {
  const DetailPhotoSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: PositionedDirectional(
        top: 0,
        start: 0,
        child: Stack(
          children: [
            PositionedDirectional(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 300,
                  imageUrl:
                      'https://staging-media.audiocult.net/file/pic/music/2021/04/1a9284a03cd8aee00cd1e86e84eec8f5.jpg',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
