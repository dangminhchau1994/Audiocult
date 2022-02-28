import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_dimens.dart';
import '../../app/utils/constants/app_font_sizes.dart';

class ErrorStateWidget extends StatelessWidget {
  final String? message;
  // ignore: use_key_in_widget_constructors
  const ErrorStateWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message ?? ''),
    );
  }
}

class EmptyDataStateWidget extends StatelessWidget {
  final String? message;
  // ignore: use_key_in_widget_constructors
  const EmptyDataStateWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.photo,
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Text(
              message ?? 'Empty Data',
              style: context
                  .buttonTextStyle()
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AppFontSize.size20),
            ),
          ],
        ),
      ),
    );
  }
}
