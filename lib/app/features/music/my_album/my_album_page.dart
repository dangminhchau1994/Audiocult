import 'package:audio_cult/app/base/pair.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_icon_button.dart';
import '../../../utils/constants/app_dimens.dart';

class MyAlbumPage extends StatelessWidget {
  const MyAlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
        vertical: kVerticalSpacing,
      ),
      child: Column(
        children: [
          CommonIconButton(
            color: AppColors.secondaryButtonColor,
            textColor: AppColors.activeLabelItem,
            text: context.l10n.t_upload,
            icon: Image.asset(AppAssets.icUpload, width: 24),
            onTap: () {
              AppDialog.showSelectionBottomSheet(
                context,
                listSelection: [
                  Pair(
                    Container(),
                    context.l10n.t_upload_song,
                  ),
                  Pair(
                    Container(),
                    context.l10n.t_upload_album,
                  ),
                ],
                onTap: (index) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, index == 0 ? AppRoute.routeUploadSong : AppRoute.routeUploadAlbum);
                },
              );
            },
          )
        ],
      ),
      // child: ListView.separated(
      //   shrinkWrap: true,
      //   itemCount: songs.length,
      //   separatorBuilder: (context, index) => const SizedBox(height: 24),
      //   itemBuilder: (context, index) {
      //     return Container();
      //   },
      // ),
    );
  }
}
