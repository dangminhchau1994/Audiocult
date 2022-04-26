import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';

class DetailPlayListPhoto extends StatelessWidget {
  const DetailPlayListPhoto({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Stack(
        children: [
          CommonImageNetWork(
            width: double.infinity,
            height: 300,
            imagePath: imagePath ?? '',
          ),
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}
