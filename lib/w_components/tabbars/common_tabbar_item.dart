import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import '../../app/utils/constants/app_colors.dart';

class CommonTabbarItem extends StatelessWidget {
  const CommonTabbarItem({
    Key? key,
    this.index,
    this.currentIndex,
    this.hasIcon,
    this.title,
    this.activeIcon,
    this.width,
    this.unActiveIcon,
  }) : super(key: key);

  final int? index; // THIS IS ORIGINAL INDEX OF ITEM DATA
  final int? currentIndex; // THIS IS CURRENT INDEX DEFINE THE ACTIVE STATUS OF THIS ITEM
  final bool? hasIcon;
  final Widget? unActiveIcon;
  final Widget? activeIcon;
  final double? width;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return TabBarItem(
      index: index ?? 0,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minWidth: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: hasIcon ?? false,
              child: index == currentIndex ? activeIcon ?? Container() : unActiveIcon ?? Container(),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title ?? '',
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: index == currentIndex ? AppColors.activeLabelItem : Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
