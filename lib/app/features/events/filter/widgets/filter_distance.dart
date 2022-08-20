import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';

import '../../../../../w_components/radios/common_radio_button.dart';
import '../../../../constants/global_constants.dart';

class FilterDistance extends StatelessWidget {
  const FilterDistance({
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
          context.localize.t_distance,
          style: context.bodyTextStyle()?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(height: 20),
          itemCount: GlobalConstants.getDistanceList(context).length,
          itemBuilder: (context, index) {
            return CommonRadioButton(
              title: GlobalConstants.getDistanceList(context)[index].keys.first,
              index: index,
              isSelected: selectedIndex == index,
              onChanged: (index) {
                onChanged!(GlobalConstants.getDistanceList(context)[index].values.first, index);
              },
            );
          },
        )
      ],
    );
  }
}
