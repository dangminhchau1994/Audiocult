import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class PageTemplateWidget extends StatelessWidget {
  final String? title;

  const PageTemplateWidget(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _bodyWrapper(context);
  }

  Widget _bodyWrapper(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.outlineBorderColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 2, color: AppColors.outlineBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(context),
          content(),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Text(
        title ?? '',
        style: context.title1TextStyle()?.copyWith(color: AppColors.pealSky),
      ),
    );
  }

  Widget content() {
    return Container(
      height: 10,
      width: 10,
      color: Colors.green,
    );
  }
}
