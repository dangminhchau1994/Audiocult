import 'package:audio_cult/app/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonInput extends StatelessWidget {
  const CommonInput({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.isHidden = false,
    this.isPasswordField = false,
    this.editingController,
    this.hintText,
    this.maxLine = 1,
    this.togglePassword,
    this.onChanged,
    this.errorText,
    this.isReadOnly = false,
    this.textInputType,
    this.fillColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final bool? isHidden;
  final bool? isPasswordField;
  final bool? isReadOnly;
  final String? hintText;
  final String? errorText;
  final Function()? togglePassword;
  final int? maxLine;
  final Function(String value)? onChanged;
  final TextEditingController? editingController;
  final TextInputType? textInputType;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isReadOnly! ? 0.4 : 1,
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          keyboardType: textInputType,
          maxLines: maxLine,
          controller: editingController,
          readOnly: isReadOnly ?? false,
          cursorColor: Colors.white,
          onChanged: onChanged,
          style: AppTextStyles.regular,
          obscureText: isHidden!,
          decoration: InputDecoration(
            filled: true,
            focusColor: AppColors.outlineBorderColor,
            fillColor: fillColor ?? AppColors.inputFillColor.withOpacity(0.4),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: AppColors.outlineBorderColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: AppColors.outlineBorderColor,
                width: 2,
              ),
            ),
            hintText: hintText,
            hintStyle: AppTextStyles.regular,
            suffixIcon: isPasswordField!
                ? InkWell(
                    onTap: togglePassword,
                    child: Icon(
                      isHidden! ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(),
            errorText: errorText,
          ),
        ),
      ),
    );
  }
}
