import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/app_colors.dart';

class GetVideo extends StatelessWidget {
  const GetVideo({
    Key? key,
    this.videoName,
    this.onRemoveFile,
  }) : super(key: key);

  final String? videoName;
  final Function()? onRemoveFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(4),
        color: AppColors.activeLabelItem.withOpacity(0.5),
        dashPattern: const [20, 6],
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.7),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
                size: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoName ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: context.buttonTextStyle()!.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.localize.t_shared_video,
                      overflow: TextOverflow.ellipsis,
                      style: context.buttonTextStyle()!.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 10),
                    WButtonInkwell(
                      onPressed: onRemoveFile,
                      child: Text(
                        context.localize.t_remove_file,
                        overflow: TextOverflow.ellipsis,
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 14,
                              color: AppColors.activeLabelItem,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
