import 'package:audio_cult/app/base/pair.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'bottom_alert_dialog.dart';

class AppDialog {
  static void showYesNoDialog(BuildContext context,
      {String? message, Function()? onYesPressed, Function()? onNoPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(context.localize.t_alert),
          content: Text(message ?? ''),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                onNoPressed?.call();
              },
              child: Text(context.localize.t_no),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                onYesPressed?.call();
              },
              child: Text(context.localize.t_yes),
            ),
          ],
        );
      },
    );
  }

  static void showBottomSheet(BuildContext context, Widget Function(BuildContext) builder) {
    showMaterialModalBottomSheet(
      context: context,
      builder: builder,
      backgroundColor: Colors.transparent,
    );
  }

  static void showSelectionBottomSheet(BuildContext context,
      {List<Pair<Pair<int, Widget>, String>>? listSelection, Function(int index)? onTap, bool isShowSelect = true}) {
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
