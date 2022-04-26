import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';

class DetailAlbumNavBar extends StatelessWidget {
  const DetailAlbumNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 20,
          ),
          child: WButtonInkwell(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            right: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryButtonColor,
            ),
            child: SvgPicture.asset(
              AppAssets.menuFilter,
              width: 30,
              height: 30,
            ),
          ),
        )
      ],
    );
  }
}
