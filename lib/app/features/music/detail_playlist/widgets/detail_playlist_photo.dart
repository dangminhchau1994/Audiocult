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
      height: 300,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CommonImageNetWork(
          width: double.infinity,
          height: 300,
          imagePath: imagePath ?? '',
        ),
      ),
    );
  }
}
