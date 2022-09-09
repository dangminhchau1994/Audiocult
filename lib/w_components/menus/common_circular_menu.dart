import 'dart:math';

import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_colors.dart';
import '../../libs/circular/circular_menu.dart';
import '../../libs/circular/circular_menu_item.dart';

class CommonCircularMenu extends StatefulWidget {
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
  State<CommonCircularMenu> createState() => _CommonCircularMenuState();
}

class _CommonCircularMenuState extends State<CommonCircularMenu> {
  bool isShow = false;
  final key = GlobalKey<CircularMenuState>();
  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      key: key,
      startingAngleInRadian: 1.25 * pi,
      endingAngleInRadian: 1.75 * pi,
      toggleButtonSize: 30,
      toggleButtonPadding: 20,
      toggleButtonOnPressed: () {
        setState(() {
          isShow = !isShow;
        });
      },
      toggleButtonColor: AppColors.primaryButtonColor,
      toggleButtonIconColor: Colors.white,
      backgroundWidget: isShow
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isShow = false;
                  key.currentState?.reverseAnimation();
                });
              },
              child: Blur(
                blur: 10,
                blurColor: AppColors.secondaryButtonColor,
                child: Container(),
              ),
            )
          : null,
      items: [
        CircularMenuItem(
          isToogleButton: false,
          onTap: () {
            setState(() {
              isShow = false;
              key.currentState?.reverseAnimation();
            });
            widget.onPostTap?.call();
          },
          label: context.localize.t_posts,
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
          onTap: () {
            setState(() {
              isShow = false;
              key.currentState?.reverseAnimation();
            });
            widget.onMusicTap?.call();
          },
          label: context.localize.t_music,
        ),
        CircularMenuItem(
          isToogleButton: false,
          icon: SvgPicture.asset(
            AppAssets.eventIcon,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              isShow = false;
              key.currentState?.reverseAnimation();
            });
            widget.onEventTap?.call();
          },
          label: context.localize.t_event,
        ),
      ],
    );
  }
}
