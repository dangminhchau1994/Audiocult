import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data_source/models/responses/feed/feed_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/route/app_route.dart';

class FeedTypeSong extends StatelessWidget {
  const FeedTypeSong({
    Key? key,
    this.customDataCache,
    this.parentFeed,
  }) : super(key: key);

  final CustomDataCache? customDataCache;
  final ParentFeed? parentFeed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              parentFeed != null ? parentFeed?.customDataCache?.title ?? '' : customDataCache?.title ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(width: 110),
          Expanded(
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: parentFeed != null ? parentFeed?.customDataCache?.totalPlay : customDataCache?.totalPlay,
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                      TextSpan(
                        text: '  plays',
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 14,
                              color: AppColors.subTitleColor,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.routeDetailSong,
                      arguments: {
                        'song_id': parentFeed != null ? parentFeed?.customDataCache?.songId : customDataCache!.songId
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    AppAssets.songDetailIcon,
                    width: 20,
                    height: 20,
                  ),
                ),
                // TODO: hidden feature in development
                // const SizedBox(width: 15),
                // WButtonInkwell(
                //   onPressed: () {
                //     ToastUtility.showPending(
                //       context: context,
                //       message: context.localize.t_feature_development,
                //     );
                //   },
                //   child: const Icon(
                //     Icons.download,
                //     color: Colors.white,
                //     size: 28,
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
