import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../utils/constants/app_assets.dart';

class StatusColorPicker extends StatelessWidget {
  const StatusColorPicker({
    Key? key,
    this.showColorPicker,
  }) : super(key: key);

  final Function()? showColorPicker;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: showColorPicker,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          AppAssets.colorPickerIcon,
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
