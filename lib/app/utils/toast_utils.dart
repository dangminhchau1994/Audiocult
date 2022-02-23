import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtility {
  static void showSuccess({BuildContext? context, String? message}) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context!);
    final Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing / 2, vertical: kVerticalSpacing / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.inputFillColor,
        border: Border.all(color: AppColors.borderOutline),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.asset(
                  AppAssets.icNotiChecked,
                  width: 24,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'Success',
                  style: context.buttonTextStyle()?.copyWith(color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () {
                  fToast.removeQueuedCustomToasts();
                  fToast.removeCustomToast();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 38), alignment: Alignment.centerLeft, child: Text(message ?? '')),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 5),
    );
  }
}
