import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_assets.dart';
import '../../app/utils/constants/app_colors.dart';

class CommonPopupMenu extends StatelessWidget {
  const CommonPopupMenu({Key? key, this.onSelected, this.items}) : super(key: key);

  final Function(int selected)? onSelected;
  final List<PopupMenuEntry<int>>? items;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: AppColors.inputFillColor,
      icon: SvgPicture.asset(
        AppAssets.horizIcon,
        width: 16,
        height: 16,
      ),
      itemBuilder: (context) => items!,
      onSelected: onSelected,
    );
  }
}
