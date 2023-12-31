import 'package:flutter/material.dart';
import '../../../../../w_components/buttons/w_button_inkwell.dart';

class EventDetailNavBar extends StatelessWidget {
  const EventDetailNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20),
      child: WButtonInkwell(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
