import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/radios/common_radio_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/common_button.dart';
import '../../../../base/pair.dart';
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
  List<Pair<int, String>> listCommons = [
    Pair(1, 'Attribution Non-commercial No Derivatives'),
    Pair(2, 'Attribution Non-commercial'),
    Pair(3, 'Attribution Share Alike'),
    Pair(4, 'Attribution Non-commercial Share Alike'),
    Pair(5, 'Attribution No Derivatives'),
    Pair(6, 'Attribution')
  ];
  int groupId1 = -1;
  int groupId2 = -1;
  int groupId3 = -1;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.t_meta_data, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonRadioButton(
              isSelected: groupId2 == 1,
              index: 1,
              title: context.l10n.t_sell,
              onChanged: (v) {
                setState(() {
                  groupId2 = v;
                });
              },
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonInput(
              labelRight: context.l10n.t_usd,
              isReadOnly: groupId2 == 2 || groupId2 == -1,
              hintText: context.l10n.t_tracking_pricing,
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonRadioButton(
              isSelected: groupId2 == 2,
              index: 2,
              title: context.l10n.t_free_download,
              onChanged: (v) {
                setState(() {
                  groupId2 = v;
                });
              },
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Text('${context.l10n.t_license}:'),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonRadioButton(
              isSelected: groupId3 == 1,
              index: 1,
              title: 'All Rights Reserved',
              onChanged: (v) {
                setState(() {
                  groupId3 = v;
                });
              },
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Text('${context.l10n.t_creative_commons}:'),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Column(
              children: listCommons
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CommonRadioButton(
                        isSelected: e.first == groupId1,
                        title: e.second,
                        index: e.first,
                        onChanged: (v) {
                          setState(() {
                            groupId1 = v;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: AppColors.secondaryButtonColor,
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
