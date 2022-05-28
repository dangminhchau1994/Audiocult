import 'dart:io';

import 'package:audio_cult/app/features/home/post_photos/widgets/post_image_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PostListImage extends StatelessWidget {
  const PostListImage({
    Key? key,
    this.listImages,
    this.onAddImage,
    this.onRemoveImage,
  }) : super(key: key);

  final List<File>? listImages;
  final Function()? onAddImage;
  final Function(int index)? onRemoveImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: onAddImage,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.activeLabelItem,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: listImages?.length ?? 0,
                itemBuilder: (context, index) => PostImageItem(
                  index: index,
                  imagePath: listImages?[index].path,
                  onRemoveImage: (index) {
                    onRemoveImage!(index);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
