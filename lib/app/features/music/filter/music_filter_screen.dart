import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/textfields/common_input_tags_grid_checkbox.dart';

class MusicFilterScreen extends StatefulWidget {
  const MusicFilterScreen({Key? key}) : super(key: key);

  @override
  State<MusicFilterScreen> createState() => _MusicFilterScreenState();
}

class _MusicFilterScreenState extends State<MusicFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        backgroundColor: AppColors.mainColor,
        title: context.l10n.t_filter,
        actions: [
          WButtonInkwell(
            borderRadius: BorderRadius.circular(8),
            onPressed: () {},
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  context.l10n.t_clear_filter,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlue),
                ),
              ),
            ),
          )
        ],
      ),
      body: WKeyboardDismiss(
        child: Container(
          height: double.infinity,
          color: AppColors.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing, vertical: kVerticalSpacing),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonDropdown(
                        dropDownWith: MediaQuery.of(context).size.width / 2 - 28,
                        data: [SelectMenuModel(id: 1, title: 'MostLiked'), SelectMenuModel(id: 1, title: 'All Time')],
                        hint: '',
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      width: kHorizontalSpacing,
                    ),
                    Expanded(
                      child: CommonDropdown(
                        dropDownWith: MediaQuery.of(context).size.width / 2 - 28,
                        data: [SelectMenuModel(id: 1, title: 'All Time')],
                        hint: '',
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kVerticalSpacing),
                  child: CommonInputTagsGridCheckBox(
                    hintText: context.l10n.t_genres,
                    listCheckBox: [
                      InputTagSelect(false, 'Mien'),
                      InputTagSelect(false, 'Mien1'),
                      InputTagSelect(false, 'Mien2')
                    ],
                  ),
                ),
                CommonInputTagsGridCheckBox(
                  hintText: context.l10n.t_tags,
                  listCheckBox: [
                    InputTagSelect(false, 'Mien'),
                    InputTagSelect(false, 'Mien1'),
                    InputTagSelect(false, 'Mien2')
                  ],
                ),
                CommonInputTagsGridCheckBox(
                  hintText: context.l10n.t_key,
                  listCheckBox: [
                    InputTagSelect(false, 'Mien'),
                    InputTagSelect(false, 'Mien1'),
                    InputTagSelect(false, 'Mien2')
                  ],
                ),
                const Align(alignment: Alignment.centerLeft, child: Text('BPM:')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
                  child: Row(
                    children: [
                      Expanded(child: CommonInput(hintText: context.l10n.t_lower)),
                      const SizedBox(
                        width: kHorizontalSpacing,
                      ),
                      Expanded(child: CommonInput(hintText: context.l10n.t_higher))
                    ],
                  ),
                ),
                CommonButton(
                  color: AppColors.activeLabelItem,
                  text: context.l10n.t_apply,
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
