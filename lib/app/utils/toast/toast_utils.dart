import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/w_notification_toast.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_assets.dart';

class ToastUtility {
  static void showSuccess({BuildContext? context, String? message}) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context!);
    final Widget toast = WNotificationToast(
      fToast: fToast,
      message: message,
      iconUrl: AppAssets.icNotiChecked,
      title: context.l10n.t_success,
    );

    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 48,
          left: 16,
          right: 16,
          child: Container(margin: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing), child: child),
        );
      },
    );
  }

  static void showError({BuildContext? context, String? message}) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context!);
    final Widget toast = WNotificationToast(
      fToast: fToast,
      message: message,
      iconUrl: AppAssets.icNotiError,
      title: context.l10n.t_error,
    );

    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 48,
          left: 16,
          right: 16,
          child: Container(margin: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing), child: child),
        );
      },
    );
  }

  static void showPending({BuildContext? context, String? message}) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context!);
    final Widget toast = WNotificationToast(
      fToast: fToast,
      message: message,
      iconUrl: AppAssets.icNotiPending,
      title: context.l10n.t_Pending,
    );

    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 48,
          left: 16,
          right: 16,
          child: Container(margin: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing), child: child),
        );
      },
    );
  }

  static void showInformation({BuildContext? context, String? message}) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context!);
    final Widget toast = WNotificationToast(
      fToast: fToast,
      message: message,
      title: context.l10n.t_information,
    );

    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 48,
          left: 16,
          right: 16,
          child: Container(margin: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing), child: child),
        );
      },
    );
  }

  static void showErrorTryAgain({BuildContext? context, String? message, Function()? onTryAgain}) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context!);
    final Widget toast = WNotificationToast(
      fToast: fToast,
      message: message,
      iconUrl: AppAssets.icNotiError,
      title: context.l10n.t_error,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
            color: AppColors.outlineBorderColor,
            width: double.infinity,
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              onTryAgain?.call();
            },
            child: Text(
              context.l10n.t_retry,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlueColor),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 5000),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 48,
          left: 16,
          right: 16,
          child: Container(margin: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing), child: child),
        );
      },
    );
  }
}
