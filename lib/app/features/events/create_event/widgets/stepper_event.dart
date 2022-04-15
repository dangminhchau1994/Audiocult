import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class StepperEvent extends StatefulWidget {
  final int currentStep;
  const StepperEvent({Key? key, this.currentStep = 1}) : super(key: key);

  @override
  State<StepperEvent> createState() => _StepperEventState();
}

class _StepperEventState extends State<StepperEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (_, index) {
              return index < widget.currentStep
                  ? Container(
                      width: MediaQuery.of(context).size.width / 5,
                      color: AppColors.activeLabelItem,
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width / 5,
                      color: AppColors.secondaryButtonColor,
                    );
            },
          ),
        ),
        Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'STEP ${widget.currentStep} OF 5',
                style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor),
              ),
            ))
      ],
    );
  }
}
