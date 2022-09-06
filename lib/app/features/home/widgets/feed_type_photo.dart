import 'dart:math';

import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeedTypePhoto extends StatelessWidget {
  const FeedTypePhoto({
    Key? key,
    this.data,
  }) : super(key: key);

  final FeedResponse? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: data?.feedStatus != null,
          child: Text(
            data?.feedStatus ?? '',
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 20),
        if (data?.feedImageUrl != null && data?.feedImageUrl?.length == 1)
          CachedNetworkImage(
            imageUrl: data?.feedImageUrl?[0] ?? '',
            fit: BoxFit.cover,
          )
        else
          const SizedBox(),
        if (data?.feedImageUrl != null && data!.feedImageUrl!.length > 1)
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            children: buildImages(data?.feedImageUrl ?? [], 4),
          )
        else
          const SizedBox(),
      ],
    );
  }

  List<Widget> buildImages(List<String> imageUrls, int maxImages) {
    final numImages = imageUrls.length;
    return List<Widget>.generate(min(numImages, maxImages), (index) {
      final imageUrl = imageUrls[index];

      if (index == maxImages - 1) {
        final remaining = numImages - maxImages;

        if (remaining == 0) {
          return CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          );
        } else {
          return GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+$remaining',
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        );
      }
    });
  }
}
