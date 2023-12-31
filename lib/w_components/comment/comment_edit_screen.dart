import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/comment/comment_list_bloc.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';

class CommentEditScreen extends StatefulWidget {
  const CommentEditScreen({
    Key? key,
    required this.argument,
    this.isEditComment,
  }) : super(key: key);

  final CommentResponse argument;
  final bool? isEditComment;

  @override
  State<CommentEditScreen> createState() => _CommentEditScreenState();
}

class _CommentEditScreenState extends State<CommentEditScreen> {
  late ValueNotifier<String> _text;
  late TextEditingController _textEditingController;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _text = ValueNotifier<String>(widget.argument.text ?? '');
    _textEditingController = TextEditingController(text: widget.argument.text ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CommonAppBar(
          title: context.localize.t_edit,
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kHorizontalSpacing,
            vertical: kVerticalSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textEditingController,
                cursorColor: Colors.white,
                autofocus: true,
                onChanged: (value) {
                  _text.value = value;
                },
                onSubmitted: (value) {},
                onTap: () {},
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CommonButton(
                          text: context.localize.t_cancel,
                          width: 150,
                          color: AppColors.secondaryButtonColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: _text,
                        builder: (context, value, child) {
                          return CommonButton(
                            onTap: value == widget.argument.text || value.isEmpty
                                ? null
                                : () {
                                    widget.argument.text = value;
                                    Navigator.pop(context, widget.argument);
                                    getIt<CommentListBloc>().editComment(
                                      value,
                                      int.parse(widget.argument.commentId ?? ''),
                                    );
                                  },
                            text: context.localize.t_submit,
                            width: 200,
                            color: AppColors.primaryButtonColor,
                          );
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
