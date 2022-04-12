import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  const CommonIconButton(
      {Key? key,
      this.text,
      this.color,
      this.onTap,
      this.iconPath = '',
      this.width = double.infinity,
      this.icon,
      this.textColor})
      : super(key: key);

  final String? text;
  final Color? color;
  final Color? textColor;
  final Function()? onTap;
  final double? width;
  final String? iconPath;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        onPressed: onTap,
        icon: icon ?? const SizedBox.shrink(),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(text ?? '', style:context.bodyTextStyle()?.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
