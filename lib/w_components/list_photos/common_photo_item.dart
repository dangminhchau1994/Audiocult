import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class CommonPhotoItem extends StatelessWidget {
  const CommonPhotoItem({
    Key? key,
    required this.entity,
    this.onTap,
    this.option,
    this.selectedIndex,
    this.index,
  }) : super(key: key);

  final AssetEntity entity;
  final GestureTapCallback? onTap;
  final int? selectedIndex;
  final int? index;
  final ThumbnailOption? option;

  Widget buildContent(BuildContext context) {
    if (entity.type == AssetType.audio) {
      return const Center(
        child: Icon(Icons.audiotrack, size: 30),
      );
    }
    return _buildImageWidget(entity, context);
  }

  Widget _buildImageWidget(AssetEntity entity, BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AssetEntityImage(
            entity,
            isOriginal: false,
            fit: BoxFit.cover,
            thumbnailSize: option!.size,
            thumbnailFormat: option!.format,
          ),
        ),
        if (selectedIndex == index)
          Positioned(
            top: 10,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryButtonColor,
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        else
          const SizedBox()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: buildContent(context),
    );
  }
}
