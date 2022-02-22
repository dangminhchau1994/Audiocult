import 'dart:math';

import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_assets.dart';
import '../../app/utils/constants/app_colors.dart';

class CommonFabMenu extends StatelessWidget {
  const CommonFabMenu({
    Key? key,
    this.onSearchTap,
    this.onCartTap,
    this.onNotificationTap,
    this.countBadge = 0,
  }) : super(key: key);

  final Function()? onSearchTap;
  final Function()? onNotificationTap;
  final Function()? onCartTap;
  final int? countBadge;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: AppColors.blurBackground,
      spaceBetweenChildren: 12,
      elevation: 0,
      dialRoot: (context, open, toggleChildren) {
        if (open) {
          return _buildActionIcon(
            const Icon(Icons.close),
            false,
          );
        } else {
          return _buildActionIcon(
            GestureDetector(
              onTap: toggleChildren,
              child: SvgPicture.asset(
                AppAssets.actionMenu,
              ),
            ),
            false,
          );
        }
      },
      direction: SpeedDialDirection.down,
      children: [
        SpeedDialChild(
          child: SvgPicture.asset(
            AppAssets.searchIcon,
            width: 50,
            height: 50,
          ),
          backgroundColor: AppColors.inputFillColor,
          foregroundColor: Colors.white,
          onTap: onSearchTap,
        ),
        SpeedDialChild(
          child: Badge(
            elevation: 0,
            badgeContent: Text('$countBadge', style: context.buttonTextStyle()),
            showBadge: countBadge! > 0 ? true : false,
            position: BadgePosition.topEnd(),
            padding: const EdgeInsets.all(6),
            badgeColor: AppColors.badgeColor,
            child: SvgPicture.asset(
              AppAssets.notificationIcon,
              width: 30,
              height: 30,
            ),
          ),
          backgroundColor: AppColors.inputFillColor,
          foregroundColor: Colors.white,
          onTap: onNotificationTap,
        ),
        SpeedDialChild(
          child: SvgPicture.asset(
            AppAssets.cartIcon,
            width: 25,
            height: 25,
          ),
          backgroundColor: AppColors.inputFillColor,
          foregroundColor: Colors.white,
          onTap: onCartTap,
        ),
      ],
    );
  }

  Widget _buildActionIcon(Widget child, bool padding) {
    return Container(
      padding: EdgeInsets.all(padding ? 8 : 0),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.inputFillColor,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
