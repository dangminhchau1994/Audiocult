import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data_source/models/responses/background/background_response.dart';
import '../../../utils/constants/app_colors.dart';

class BackgroundItem extends StatelessWidget {
  const BackgroundItem({
    Key? key,
    this.data,
    this.onItemClick,
  }) : super(key: key);

  final BackgroundsList? data;
  final Function(BackgroundsList data)? onItemClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemClick!(data!);
      },
      child: CachedNetworkImage(
        width: 50,
        height: 50,
        imageUrl: data?.imageUrl ?? '',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryButtonColor,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
