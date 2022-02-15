import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import '../../app/utils/constants/app_colors.dart';

class CommonTabbarItem extends StatelessWidget {
  const CommonTabbarItem({
    Key? key,
    this.index,
    this.currentIndex,
    this.hasIcon,
    this.icon,
  }) : super(key: key);

  final int? index; // THIS IS ORIGINAL INDEX OF ITEM DATA
  final int? currentIndex; // THIS IS CURRENT INDEX DEFINE THE ACTIVE STATUS OF THIS ITEM
  final bool? hasIcon;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TabBarItem(
      index: index ?? 0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: hasIcon ?? false,
              child: icon ?? Container(),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Tab$index',
              style: TextStyle(
                fontSize: 18,
                color: index == currentIndex ? AppColors.activeLabelItem : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
