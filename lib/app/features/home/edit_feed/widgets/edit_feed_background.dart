import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';

import '../../../../../w_components/images/common_image_network.dart';
import '../../../../utils/constants/app_colors.dart';

class EditFeedBackGround extends StatelessWidget {
  const EditFeedBackGround({
    Key? key,
    this.textEditingController,
    this.imagePath,
    this.onChanged,
    this.onClose,
  }) : super(key: key);

  final String? imagePath;
  final TextEditingController? textEditingController;
  final Function(String? value)? onChanged;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CommonImageNetWork(
          imagePath: imagePath,
          width: double.infinity,
          height: 290,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 4,
            bottom: MediaQuery.of(context).size.width / 4,
          ),
          child: TextField(
            controller: textEditingController,
            maxLines: 3,
            textAlign: TextAlign.center,
            onChanged: (value) {
              onChanged!(value);
            },
            decoration: InputDecoration(
              hintText: context.localize.t_what_new,
              hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: onClose,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.close,
                size: 25,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
