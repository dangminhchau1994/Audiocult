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
    this.song,
  }) : super(key: key);

  final CustomDataCache? song;

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
              song?.title ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(width: 80),
          Expanded(
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: song?.totalPlay ?? '0',
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
                      arguments: {'song_id': song!.songId},
                    );
                  },
                  child: SvgPicture.asset(
                    AppAssets.songDetailIcon,
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.download,
                  color: Colors.white,
                  size: 28,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
