import 'package:flutter/material.dart';

import '../../../../../w_components/images/common_image_network.dart';

class EventDetailPhoto extends StatelessWidget {
  const EventDetailPhoto({
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
      child: CommonImageNetWork(
        width: double.infinity,
        height: 300,
        imagePath: imagePath ?? '',
      ),
    );
  }
}
