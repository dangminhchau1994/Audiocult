import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonMultiPhotoItem extends StatelessWidget {
  const CommonMultiPhotoItem({
    Key? key,
    required this.entity,
    this.onTap,
    this.option,
    this.onLongTap,
    this.selectItems,
    this.selectedIndex,
    this.index,
  }) : super(key: key);

  final AssetEntity entity;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongTap;
  final int? selectedIndex;
  final int? index;
  final HashSet? selectItems;
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
          onLongPress: onLongTap,
          child: AssetEntityImage(
            entity,
            isOriginal: false,
            fit: BoxFit.cover,
            thumbnailSize: option!.size,
            thumbnailFormat: option!.format,
          ),
        ),
        Visibility(
          visible: selectItems!.contains(entity.id),
          child: Positioned(
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
          ),
        )
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
