import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class EventDetailTitle extends StatelessWidget {
  const EventDetailTitle({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 20,
      child: Text(
        'Oblivion : Chapter 2 ',
        style: context.bodyTextPrimaryStyle()!.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
