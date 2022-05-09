import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song_detail/song_detail_response.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_description_label.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

import '../../../../utils/constants/app_colors.dart';

class DetailSongDescription extends StatelessWidget {
  const DetailSongDescription({
    Key? key,
    this.data,
  }) : super(key: key);

  final Song? data;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
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
                  value: data?.artistUser?.userName ?? 'N/A',
                ),
                const SizedBox(
                  width: 32,
                ),
                DetailDescriptionLabel(
                  title: 'LABEL',
                  value: data?.labelUser?.userName ?? 'N/A',
                ),
                const SizedBox(
                  width: 32,
                ),
                const DetailDescriptionLabel(
                  title: 'Remixers',
                  value: '',
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //second row
            Row(
              children: [
                DetailDescriptionLabel(
                  title: 'GENRE',
                  value: data?.genreName ?? 'N/A',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //genre tags
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: data!.tags!
                  .split('')
                  .map(
                    (e) => Text(
                      e,
                      style: TextStyle(color: AppColors.lightBlue),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            //read more text
            if (data?.description != null)
              ReadMoreText(
                data?.description ?? '',
                trimLines: 3,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: context.l10n.t_read_more,
                trimExpandedText: context.l10n.t_read_less,
                moreStyle: TextStyle(
                  color: AppColors.lightBlueColor,
                ),
                lessStyle: TextStyle(
                  color: AppColors.lightBlueColor,
                ),
              )
            else
              const SizedBox(),
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
