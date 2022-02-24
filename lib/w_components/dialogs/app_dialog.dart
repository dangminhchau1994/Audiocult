import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}
