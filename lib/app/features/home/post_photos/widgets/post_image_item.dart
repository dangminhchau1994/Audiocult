import 'dart:io';

import 'package:flutter/material.dart';

class PostImageItem extends StatelessWidget {
  const PostImageItem({Key? key, this.imagePath}) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.file(
            File(imagePath ?? ''),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
          Positioned(
            top: 0,
            right: 4,
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
          )
        ],
      ),
    );
  }
}
