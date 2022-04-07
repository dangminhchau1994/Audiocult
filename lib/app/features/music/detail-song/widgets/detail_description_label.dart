import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class DetailDescriptionLabel extends StatelessWidget {
  const DetailDescriptionLabel({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: AppColors.subTitleColor,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value ?? '',
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
