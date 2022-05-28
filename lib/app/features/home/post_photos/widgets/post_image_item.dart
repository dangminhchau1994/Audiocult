import 'dart:io';

import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

class PostImageItem extends StatelessWidget {
  const PostImageItem({
    Key? key,
    this.imagePath,
    this.onRemoveImage,
    this.index,
  }) : super(key: key);

  final String? imagePath;
  final int? index;
  final Function(int index)? onRemoveImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.file(
              File(imagePath ?? ''),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            top: 0,
            right: 4,
            child: WButtonInkwell(
              onPressed: () {
                onRemoveImage!(index!);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
