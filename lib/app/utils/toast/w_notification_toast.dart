import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

class WNotificationToast extends StatelessWidget {
  const WNotificationToast({
    Key? key,
    required this.fToast,
    this.message,
    this.iconUrl,
    this.title,
    this.isTryAgain = false,
    this.child,
  }) : super(key: key);

  final FToast fToast;
  final String? message;
  final String? iconUrl;
  final String? title;
  final bool isTryAgain;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing / 2, vertical: kVerticalSpacing / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.inputFillColor,
        border: Border.all(color: AppColors.borderOutline),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: iconUrl == null
                      ? const SizedBox.shrink()
                      : Image.asset(
                          iconUrl!,
                          width: 24,
                        ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? '',
                        style: context.headerStyle()?.copyWith(color: Colors.white),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(message ?? ''),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 8),
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      fToast.removeQueuedCustomToasts();
                      fToast.removeCustomToast();
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            child ?? Container()
          ],
        ),
      ),
    );
  }
}
