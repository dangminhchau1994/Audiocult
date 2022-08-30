import 'dart:io';

import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_assets.dart';
import '../../app/utils/constants/app_colors.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({
    Key? key,
    this.textEditingController,
    this.emojiShowing,
    this.text,
    this.submitComment,
    this.onEmojiSelected,
    this.onBackspacePressed,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final ValueNotifier<bool>? emojiShowing;
  final ValueNotifier<String>? text;
  final Function()? submitComment;
  final Function(Emoji emoji)? onEmojiSelected;
  final Function()? onBackspacePressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondaryButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ValueListenableBuilder<String>(
                valueListenable: text!,
                builder: (context, value, child) => TextField(
                  focusNode: focusNode,
                  cursorColor: Colors.white,
                  autofocus: true,
                  controller: textEditingController,
                  onChanged: (value) {
                    text!.value = value;
                  },
                  onSubmitted: (value) {
                    if (text!.value.isNotEmpty) {
                      submitComment!();
                    }
                  },
                  onTap: () {
                    emojiShowing!.value = false;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: AppColors.outlineBorderColor,
                    fillColor: AppColors.secondaryButtonColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: AppColors.outlineBorderColor,
                        width: 2,
                      ),
                    ),
                    suffixIcon: value.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              emojiShowing!.value = !emojiShowing!.value;
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                AppAssets.faceIcon,
                                width: 12,
                                height: 12,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (text!.value.isNotEmpty) {
                                submitComment!();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryButtonColor,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: AppColors.outlineBorderColor,
                        width: 2,
                      ),
                    ),
                    hintText: context.localize.t_leave_comment,
                    hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                          color: AppColors.subTitleColor,
                        ),
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                builder: (context, value, child) => Offstage(
                  offstage: !value,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (Category category, Emoji emoji) {
                        onEmojiSelected!(emoji);
                      },
                      onBackspacePressed: onBackspacePressed,
                      config: Config(
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        emojiSizeMax: 18 * (Platform.isIOS ? 1.30 : 1.0),
                        bgColor: AppColors.secondaryButtonColor,
                      ),
                    ),
                  ),
                ),
                valueListenable: emojiShowing!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
