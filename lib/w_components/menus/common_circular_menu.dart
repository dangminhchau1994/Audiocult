import 'dart:math';

import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_colors.dart';
import '../../app/utils/libs/circular_menu.dart';
import '../../app/utils/libs/circular_menu_item.dart';

class CommonCircularMenu extends StatelessWidget {
  const CommonCircularMenu({
    Key? key,
    this.onPostTap,
    this.onMusicTap,
    this.onEventTap,
  }) : super(key: key);

  final Function()? onPostTap;
  final Function()? onMusicTap;
  final Function()? onEventTap;

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      startingAngleInRadian: 1.25 * pi,
      endingAngleInRadian: 1.75 * pi,
      toggleButtonSize: 30,
      toggleButtonPadding: 20,
      toggleButtonOnPressed: () {},
      toggleButtonColor: AppColors.primaryButtonColor,
      toggleButtonIconColor: Colors.white,
      items: [
        CircularMenuItem(
          isToogleButton: false,
          onTap: onPostTap ?? () {},
          label: 'Posts',
          icon: SvgPicture.asset(
            AppAssets.postIcon,
            color: Colors.white,
          ),
        ),
        CircularMenuItem(
          isToogleButton: false,
          icon: SvgPicture.asset(
            AppAssets.musicIcon,
            color: Colors.white,
          ),
          onTap: onMusicTap ?? () {},
          label: 'Music',
        ),
        CircularMenuItem(
          isToogleButton: false,
          icon: SvgPicture.asset(
            AppAssets.eventIcon,
            color: Colors.white,
          ),
          onTap: onEventTap ?? () {},
          label: 'Event',
        ),
      ],
    );
  }
}
