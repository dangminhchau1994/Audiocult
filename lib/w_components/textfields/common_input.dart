import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonInput extends StatelessWidget {
  const CommonInput({
    Key? key,
    this.width = double.infinity,
    this.height,
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
    this.labelRight,
    this.suffixIcon,
    this.fillColor,
    this.onTap,
    this.focusNode,
    this.isBorderVisible = true,
  }) : super(key: key);

  final double? width;
  final double? height;
  final bool? isHidden;
  final bool? isPasswordField;
  final bool? isReadOnly;
  final String? hintText;
  final String? errorText;
  final Function()? togglePassword;
  final Function()? onTap;
  final int? maxLine;
  final Function(String value)? onChanged;
  final TextEditingController? editingController;
  final TextInputType? textInputType;
  final String? labelRight;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool isBorderVisible;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: isReadOnly! ? 0.4 : 1,
          child: SizedBox(
            width: width,
            height: height,
            child: Center(
              child: TextFormField(
                focusNode: focusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType: textInputType ?? TextInputType.text,
                maxLines: maxLine,
                onTap: onTap,
                controller: editingController,
                readOnly: isReadOnly ?? false,
                cursorColor: Colors.white,
                onChanged: onChanged,
                obscureText: isHidden!,
                decoration: InputDecoration(
                  filled: true,
                  focusColor: AppColors.outlineBorderColor,
                  fillColor: fillColor ?? AppColors.inputFillColor.withOpacity(0.4),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: !isBorderVisible
                        ? BorderSide.none
                        : BorderSide(
                            color: AppColors.outlineBorderColor,
                            width: 2,
                          ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: !isBorderVisible
                        ? BorderSide.none
                        : BorderSide(
                            color: Colors.red.withOpacity(0.4),
                            width: 2,
                          ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: !isBorderVisible
                        ? BorderSide.none
                        : BorderSide(
                            color: Colors.red.withOpacity(0.4),
                            width: 2,
                          ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: !isBorderVisible
                        ? BorderSide.none
                        : BorderSide(
                            color: AppColors.outlineBorderColor,
                            width: 2,
                          ),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(color: AppColors.unActiveLabelItem),
                  suffixIcon: isPasswordField!
                      ? InkWell(
                          onTap: togglePassword,
                          child: Icon(
                            isHidden! ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.white,
                          ),
                        )
                      : Container(padding: const EdgeInsets.all(18), child: suffixIcon ?? const SizedBox()),
                  errorText: errorText,
                ),
              ),
            ),
          ),
        ),
        if (labelRight != null)
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                labelRight!,
                style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline),
              ),
            ),
          )
        else
          const SizedBox.shrink()
      ],
    );
  }
}
