import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 18,
              ),
        ),
        Text(
          'Show All',
          style: context.bodyTextPrimaryStyle()!.copyWith(
                fontSize: 16,
                color: AppColors.lightBlue,
              ),
        ),
      ],
    );
  }
}
