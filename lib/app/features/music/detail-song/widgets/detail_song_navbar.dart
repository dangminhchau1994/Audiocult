import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../playlist_dialog.dart';

class DetailSongNavBar extends StatelessWidget {
  const DetailSongNavBar({
    Key? key,
    this.songId,
  }) : super(key: key);

  final String? songId;

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
        GestureDetector(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return PlayListDialog(
                  songId: songId,
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              right: 10,
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
          ),
        )
      ],
    );
  }
}
