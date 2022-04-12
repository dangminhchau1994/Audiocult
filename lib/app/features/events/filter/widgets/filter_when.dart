import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/radios/common_radio_button.dart';
import 'package:flutter/material.dart';

class FilterWhen extends StatelessWidget {
  const FilterWhen({
    Key? key,
    this.onChanged,
    this.selectedIndex,
  }) : super(key: key);

  final Function(String value, int index)? onChanged;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.t_when,
          style: context.bodyTextStyle()?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(height: 20),
          itemCount: GlobalConstants.getWhenList().length,
          itemBuilder: (context, index) {
            return CommonRadioButton(
              index: index,
              isSelected: selectedIndex == index,
              title: GlobalConstants.getWhenList()[index].keys.first,
              onChanged: (index) {
                onChanged!(GlobalConstants.getWhenList()[index].values.first, index);
              },
            );
          },
        )
      ],
    );
  }
}
