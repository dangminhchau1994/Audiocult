import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/datetime/date_time_utils.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({Key? key, this.data}) : super(key: key);

  final FeedResponse? data;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  final HomeBloc _homeBloc = HomeBloc(locator.get());

  @override
  void initState() {
    // _homeBloc.getComments(int.parse(widget.data?.feedId ?? ''), 'music_song', 1, 3, 'latest');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryButtonColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: widget.data?.userImage ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryButtonColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.data?.userName ?? ''} ${widget.data?.feedInfo}',
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateTimeUtils.convertToAgo(int.parse(widget.data?.timeStamp ?? '')),
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              _buildBody(widget.data!.getFeedType()),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildIcon(
                        SvgPicture.asset(AppAssets.heartIcon),
                        widget.data!.totalLikes.toString(),
                        context,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildIcon(
                        SvgPicture.asset(AppAssets.commentIcon),
                        widget.data?.totalComment ?? '',
                        context,
                      )
                    ],
                  ),
                  _buildViewCount(widget.data?.totalView ?? '', context)
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 0.5, color: Colors.grey),
              const SizedBox(height: 20),
              CommonInput(
                maxLine: 5,
                hintText: context.l10n.t_leave_comment,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildViewCount(
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.viewIcons,
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

  Widget _buildBody(FeedType feedType) {
    switch (feedType) {
      case FeedType.advancedEvent:
        return Html(
          data: widget.data?.feedCustomHtml ?? '',
        );
      case FeedType.userStatus:
        return Text(
          widget.data?.feedStatus ?? '',
          style: context.buttonTextStyle()!.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
        );
      case FeedType.photo:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data?.feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 14,
              mainAxisSpacing: 25,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 8 / 2,
              children: widget.data!.feedImage!.map((e) => Html(data: e)).toList(),
            ),
          ],
        );
      case FeedType.userCover:
        return Container();
      case FeedType.userPhoto:
        return Container();
      case FeedType.advancedSong:
        return Html(
          data: widget.data?.feedCustomHtml ?? '',
        );
      case FeedType.video:
        return Container();
      case FeedType.none:
        return Container();
    }
  }
}
