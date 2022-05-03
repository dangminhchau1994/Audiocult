import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PageTemplateWidget extends StatelessWidget {
  final String? title;

  const PageTemplateWidget(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _bodyWrapper();
  }

  Widget _bodyWrapper() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      // padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          color: AppColors.outlineBorderColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 2, color: AppColors.outlineBorderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          content(),
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Text(title ?? ''),
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
