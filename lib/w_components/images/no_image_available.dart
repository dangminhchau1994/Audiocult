import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

class NoImageAvailable extends StatelessWidget {
  final double? width;
  final double? height;

  const NoImageAvailable({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: const Color(0xffE9E9E9),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image, color: Color(0xff9f9f9f), size: 48),
                const SizedBox(height: 8.0),
                Text(context.l10n.t_no_image_available,
                    style: const TextStyle(color: Color(0xff7F7F7F), fontSize: 16.0))
              ],
            )),
      ),
    );
  }
}
