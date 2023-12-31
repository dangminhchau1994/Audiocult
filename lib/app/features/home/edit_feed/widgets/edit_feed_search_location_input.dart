import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../utils/constants/app_assets.dart';

class EditFeedSearchLocationInput extends StatelessWidget {
  const EditFeedSearchLocationInput({
    Key? key,
    this.searchLocation,
    this.showIcon,
  }) : super(key: key);

  final Function()? searchLocation;
  final bool? showIcon;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showIcon!,
      child: WButtonInkwell(
        onPressed: searchLocation,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            AppAssets.locationIcon,
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }
}
