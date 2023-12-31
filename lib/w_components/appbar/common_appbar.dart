import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title,
    this.backgroundColor,
    this.leadingWidth,
    this.centerTitle,
    this.height,
  }) : super(key: key);

  final Widget? leading;
  final List<Widget>? actions;
  final String? title;
  final Color? backgroundColor;
  final bool? centerTitle;
  final double? leadingWidth;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.secondaryButtonColor,
      elevation: 0,
      leadingWidth: leadingWidth,
      centerTitle: centerTitle ?? true,
      bottomOpacity: 0,
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(4),
          ),
      actions: actions,
      title: Text(
        title ?? '',
        style: context.headerStyle(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 50);
}
