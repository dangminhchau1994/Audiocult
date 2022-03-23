import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonBottomBar extends StatelessWidget {
  const CommonBottomBar({Key? key, this.currentIndex, this.onTap, this.topWidget}) : super(key: key);

  final int? currentIndex;
  final Function(int index)? onTap;
  final Widget? topWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Blur(blur: 10, blurColor: AppColors.secondaryButtonColor.withOpacity(0.75), child: Container()),
        ),
        Column(
          children: [
            topWidget ?? const SizedBox.shrink(),
            BottomNavigationBar(
              elevation: 0,
              backgroundColor: AppColors.secondaryButtonColor.withOpacity(0.75),
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: currentIndex == 0
                      ? SvgPicture.asset(AppAssets.homeActiveIcon)
                      : SvgPicture.asset(
                          AppAssets.homeIcon,
                        ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: currentIndex == 1
                      ? SvgPicture.asset(AppAssets.atlasActiveIcon)
                      : SvgPicture.asset(AppAssets.atlasIcon),
                  label: 'Atlas',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox(),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: currentIndex == 3
                      ? SvgPicture.asset(AppAssets.musicActiveIcon)
                      : SvgPicture.asset(AppAssets.musicIcon),
                  label: 'Music',
                ),
                BottomNavigationBarItem(
                  icon: currentIndex == 4
                      ? SvgPicture.asset(AppAssets.eventActiveIcon)
                      : SvgPicture.asset(AppAssets.eventIcon),
                  label: 'Events',
                ),
              ],
              currentIndex: currentIndex ?? 0,
              onTap: onTap,
              selectedItemColor: AppColors.activeLabelItem,
              unselectedItemColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
