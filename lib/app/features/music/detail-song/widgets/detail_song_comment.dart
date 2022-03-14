import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/comment/common_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../utils/constants/app_colors.dart';

class DetailSongComment extends StatelessWidget {
  const DetailSongComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: 5,
            cursorColor: Colors.white,
            onChanged: (value) {},
            style: AppTextStyles.regular,
            decoration: InputDecoration(
              filled: true,
              focusColor: AppColors.outlineBorderColor,
              fillColor: AppColors.secondaryButtonColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              hintText: context.l10n.t_leave_comment,
              hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.lightWhiteColor,
                    fontSize: 14,
                  ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: SvgPicture.asset(
                  AppAssets.faceIcon,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: SizedBox(
              height: 390,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => const Divider(height: 30),
                itemBuilder: (context, index) => const CommonComment(),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: AppColors.secondaryButtonColor,
            height: 1,
          ),
        ],
      ),
    );
  }
}
