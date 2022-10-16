import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:flutter/material.dart';
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
      child: CommonButton(
        width: 130,
        color: AppColors.primaryButtonColor,
        text: context.localize.t_browse,
      ),
    );
  }
}
