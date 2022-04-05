import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyPlayList extends StatelessWidget {
  const EmptyPlayList({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 140),
        child: Column(
          children: [
            SvgPicture.asset(
              AppAssets.circlePlay,
              width: 40,
              height: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title ?? '',
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              content ?? '',
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
