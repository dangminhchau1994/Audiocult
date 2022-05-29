import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UniversalSearchWrapper extends StatelessWidget {
  final List<Widget> children;

  const UniversalSearchWrapper(this.children, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        color: AppColors.mainColor,
        child: Column(mainAxisSize: MainAxisSize.max, children: children),
      ),
    );
  }
}
