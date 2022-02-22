import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title,
  }) : super(key: key);

  final Widget? leading;
  final List<Widget>? actions;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryButtonColor,
      elevation: 0,
      centerTitle: true,
      bottomOpacity: 0,
      leading: leading,
      actions: actions,
      title: Text(
        title ?? '',
        style: context.buttonTextStyle(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
