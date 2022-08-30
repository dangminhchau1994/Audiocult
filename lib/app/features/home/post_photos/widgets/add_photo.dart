import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/app_colors.dart';

class AddPhoto extends StatelessWidget {
  const AddPhoto({Key? key, this.onAddPhoto}) : super(key: key);

  final Function()? onAddPhoto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddPhoto,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.activeLabelItem,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.upload,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.localize.t_upload_multi_photo,
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 16,
                              color: AppColors.activeLabelItem,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        context.localize.t_recommended_upload,
                        overflow: TextOverflow.ellipsis,
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                      ),
                    ],
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
