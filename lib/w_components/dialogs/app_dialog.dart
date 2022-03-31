import 'package:audio_cult/app/base/pair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_alert_dialog.dart';

class AppDialog {
  static void showYesNoDialog(BuildContext context, {String? message, Function()? onYesPressed}) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Alert'),
          content: Text(message ?? ''),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                onYesPressed?.call();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static void showSelectionBottomSheet(BuildContext context,
      {List<Pair<Pair<int,Widget>, String>>? listSelection, Function(int index)? onTap, bool isShowSelect = true}) {
    showModalBottomSheet(
        context: context,
        builder: (_) => BottomAlertDialog(
              listSelection: listSelection,
              onTap: onTap,
              isShowSelect: isShowSelect,
            ),
        backgroundColor: Colors.transparent);
  }
}
