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
  const DetailSongDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  color: AppColors.lightWhiteColor,
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          //first row
          Row(
            children: const [
              DetailDescriptionLabel(
                title: 'Artist',
                value: 'Element9',
              ),
              SizedBox(
                width: 32,
              ),
              DetailDescriptionLabel(
                title: 'Artist',
                value: 'Element9',
              ),
              SizedBox(
                width: 32,
              ),
              DetailDescriptionLabel(
                title: 'Artist',
                value: 'Element9',
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //second row
          Row(
            children: const [
              DetailDescriptionLabel(
                title: 'Artist',
                value: 'Element9',
              ),
              SizedBox(
                width: 32,
              ),
              DetailDescriptionLabel(
                title: 'Artist',
                value: 'Element9',
              ),
              SizedBox(
                width: 32,
              ),
              DetailDescriptionLabel(
                title: 'Artist',
                value: 'Element9',
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //genre tags
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Text(
                '#psytrance ',
                style: TextStyle(
                  color: AppColors.lightBlueColor,
                ),
              ),
              Text(
                '#psytrance ',
                style: TextStyle(
                  color: AppColors.lightBlueColor,
                ),
              ),
              Text(
                '#psytrance ',
                style: TextStyle(
                  color: AppColors.lightBlueColor,
                ),
              ),
              Text(
                '#psytrance ',
                style: TextStyle(
                  color: AppColors.lightBlueColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //read more text
          ReadMoreText(
            """Written in 2018 we wanted to create a track that had that nice atmosphere of a slow bumping psy-trance base but mixed with a TechnoDrum-Kick. 
            \nIt wasnt that easy and i think 
            the actual Kick&base took at least 3-4 hours to actually 
            get it working to a point where we could working with the rest of the track.\n """,
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
          ),
          const SizedBox(
            height: 40,
          ),
          //heart, comment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildIcon(
                    SvgPicture.asset(AppAssets.heartIcon),
                    149,
                    context,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildIcon(
                    SvgPicture.asset(AppAssets.commentIcon),
                    10,
                    context,
                  )
                ],
              ),
              _buildPlayCount(113, context)
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

  Widget _buildIcon(Widget icon, int value, BuildContext context) {
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
            value.toString(),
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildPlayCount(
    int value,
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
            value.toString(),
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
