import 'package:audio_cult/app/data_source/models/requests/upload_request.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/radios/common_radio_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/common_button.dart';
import '../../../../base/pair.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';
import '../../../../utils/toast/toast_utils.dart';

class MetaDataStep extends StatefulWidget {
  final Function()? onCompleted;

  final Function()? onBack;
  const MetaDataStep({Key? key, this.onBack, this.onCompleted}) : super(key: key);

  @override
  State<MetaDataStep> createState() => MetaDataStepState();
}

class MetaDataStepState extends State<MetaDataStep> {
  List<Pair<int, Pair<String, String>>> listCommons = [
    Pair(1, Pair('non_commercial_no_derivatives', 'Attribution Non-commercial No Derivatives')),
    Pair(
      2,
      Pair('non_commercial', 'Attribution Non-commercial'),
    ),
    Pair(
      3,
      Pair('share_alike', 'Attribution Share Alike'),
    ),
    Pair(
      4,
      Pair('non_commercial_share_alike', 'Attribution Non-commercial Share Alike'),
    ),
    Pair(
      5,
      Pair('no_derivatives', 'Attribution No Derivatives'),
    ),
    Pair(6, Pair('attribution', 'Attribution'))
  ];
  List<Pair<int, Pair<String, String>>> listLicense = [
    Pair(7, Pair('all_rights_reserved', 'All Rights Reserved')),
  ];
  int groupId1 = -1;
  int groupId2 = -1;
  final UploadRequest _uploadRequest = UploadRequest();

  UploadRequest get getValue {
    return _uploadRequest;
  }

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
                  _uploadRequest.isFree = v;
                });
              },
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonInput(
              labelRight: context.l10n.t_usd,
              isReadOnly: groupId2 == -1 || groupId2 == 0,
              hintText: context.l10n.t_tracking_pricing,
              textInputType: TextInputType.number,
              onChanged: (v) {
                setState(() {
                  _uploadRequest.cost = double.tryParse(v);
                });
              },
            ),
            const SizedBox(
              height: kVerticalSpacing,
            ),
            CommonRadioButton(
              isSelected: groupId2 == 0,
              index: 0,
              title: context.l10n.t_free_download,
              onChanged: (v) {
                setState(() {
                  groupId2 = v;
                  _uploadRequest.isFree = v;
                  _uploadRequest.cost = 0;
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
              isSelected: groupId1 == 7,
              index: 7,
              title: listLicense[0].second.second,
              onChanged: (v) {
                setState(() {
                  groupId1 = v;
                  _uploadRequest.licenseType = listLicense[0].second.first;
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
                        title: e.second.second,
                        index: e.first,
                        onChanged: (v) {
                          setState(() {
                            groupId1 = v;
                            _uploadRequest.licenseType = e.second.first;
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
                      if (groupId1 == -1 || groupId2 == -1) {
                        ToastUtility.showError(context: context, message: 'Please fill all information');
                      } else {
                        widget.onCompleted?.call();
                      }
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
