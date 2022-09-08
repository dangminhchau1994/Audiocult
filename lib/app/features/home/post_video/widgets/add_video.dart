import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/constants/app_colors.dart';

class AddVideo extends StatelessWidget {
  const AddVideo({
    Key? key,
    this.onAddVideo,
  }) : super(key: key);

  final Function()? onAddVideo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddVideo,
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(4),
          padding: const EdgeInsets.all(4),
          color: AppColors.activeLabelItem.withOpacity(0.5),
          dashPattern: const [20, 6],
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryButtonColor.withOpacity(0.7),
            ),
            width: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset(
                          AppAssets.activeVideo,
                          width: 30,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.localize.t_add_video_title,
                              style: context.buttonTextStyle()!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.activeLabelItem,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              context.localize.t_add_video_content,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.buttonTextStyle()!.copyWith(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CommonButton(
                    width: 130,
                    color: AppColors.primaryButtonColor,
                    text: context.localize.t_browse,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
