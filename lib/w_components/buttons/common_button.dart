import 'package:audio_cult/app/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    this.text,
    this.color,
    this.onTap,
    this.iconPath = '',
    this.width = double.infinity,
  }) : super(key: key);

  final String? text;
  final Color? color;
  final Function()? onTap;
  final double? width;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(text ?? '', style: AppTextStyles.regular),
        ),
      ),
    );
  }
}
