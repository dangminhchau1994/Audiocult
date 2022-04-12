import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';
import '../../detail-song/widgets/detail_description_label.dart';

class DetailAlbumDescription extends StatelessWidget {
  final Album? data;

  const DetailAlbumDescription({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kVerticalSpacing,
        left: kVerticalSpacing,
        right: kVerticalSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.t_description,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: AppColors.subTitleColor,
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          //first row
          Row(
            children: [
              DetailDescriptionLabel(
                title: 'ARTIST',
                value: data?.artistUser?.fullName ?? 'N/A',
              ),
              const SizedBox(
                width: 32,
              ),
              DetailDescriptionLabel(
                title: 'LABEL',
                value: data?.labelUser?.fullName ?? 'N/A',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          //heart, comment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildIcon(
                    SvgPicture.asset(AppAssets.heartIcon),
                    data?.totalLike ?? '',
                    context,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildIcon(
                    SvgPicture.asset(AppAssets.commentIcon),
                    data?.totalComment ?? '',
                    context,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.secondaryButtonColor,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: SvgPicture.asset(AppAssets.shareIcon),
                    ),
                  )
                ],
              ),
              _buildPlayCount(data?.totalPlay ?? '', context)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            color: AppColors.secondaryButtonColor,
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _buildIcon(Widget icon, String value, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryButtonColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 14,
          ),
          Text(
            value,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildPlayCount(
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.playCountIcon,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
