import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/common_button.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';

class MetaDataStep extends StatefulWidget {
  final Function()? onCompleted;

  final Function()? onBack;
  const MetaDataStep({Key? key, this.onBack, this.onCompleted}) : super(key: key);

  @override
  State<MetaDataStep> createState() => _MetaDataStepState();
}

class _MetaDataStepState extends State<MetaDataStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: AppColors.semiMainColor,
                    text: context.l10n.btn_back,
                    onTap: () {
                      widget.onBack?.call();
                    },
                  ),
                ),
                const SizedBox(
                  width: kVerticalSpacing,
                ),
                Expanded(
                  child: CommonButton(
                    color: AppColors.primaryButtonColor,
                    text: context.l10n.btn_completed,
                    onTap: () {
                      widget.onCompleted?.call();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
