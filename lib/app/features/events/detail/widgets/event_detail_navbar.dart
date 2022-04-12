import 'package:flutter/material.dart';
import '../../../../../w_components/buttons/w_button_inkwell.dart';

class EventDetailNavBar extends StatelessWidget {
  const EventDetailNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
        left: 23,
        right: 23,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WButtonInkwell(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
