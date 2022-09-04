import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

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
          context.localize.t_when,
          style: context.bodyTextStyle()?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(height: 20),
          itemCount: GlobalConstants.getWhenList(context).length,
          itemBuilder: (context, index) {
            return CommonRadioButton(
              index: index,
              isSelected: selectedIndex == index,
              title: GlobalConstants.getWhenList(context)[index].keys.first,
              onChanged: (index) {
                onChanged!(GlobalConstants.getWhenList(context)[index].values.first, index);
              },
            );
          },
        )
      ],
    );
  }
}
