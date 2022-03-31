import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingBlur extends StatelessWidget {
  const LoadingBlur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: AppColors.secondaryButtonColor,
          ),
          child: const Center(
            child: LoadingWidget(),
          ),
        ),
      ),
    );
  }
}
