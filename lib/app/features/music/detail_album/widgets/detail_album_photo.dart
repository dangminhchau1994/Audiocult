import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';


class DetailAlbumPhoto extends StatelessWidget {
  const DetailAlbumPhoto({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: PositionedDirectional(
        top: 0,
        start: 0,
        child: Stack(
          children: [
            PositionedDirectional(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: CommonImageNetWork(
                  width: double.infinity,
                  height: 300,
                  imagePath: imagePath ?? '',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
