import 'dart:io';

import 'package:audio_cult/app/features/home/post_photos/widgets/post_image_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PostListImage extends StatelessWidget {
  const PostListImage({
    Key? key,
    this.listImages,
    this.onAddImage,
  }) : super(key: key);

  final List<File>? listImages;
  final Function()? onAddImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          GestureDetector(
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
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: listImages?.length ?? 0,
                itemBuilder: (context, index) => PostImageItem(
                  imagePath: listImages?[index].path,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
