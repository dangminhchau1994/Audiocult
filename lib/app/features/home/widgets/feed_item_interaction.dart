import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/comment/comment_args.dart';
import '../../../../w_components/comment/comment_list_screen.dart';
import '../../../../w_components/reactions/common_reaction.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/route/app_route.dart';

class FeedItemInteraction extends StatelessWidget {
  const FeedItemInteraction({
    Key? key,
    this.data,
    this.fromEventFeed,
  }) : super(key: key);

  final FeedResponse? data;
  final bool? fromEventFeed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CommonReactions(
              reactionType: fromEventFeed! ? ReactionType.feed : ReactionType.eventComment,
              itemId: data?.feedId ?? '',
              eventFeedItemId: data?.itemId ?? '',
              totalLike: data?.feedTotalLike.toString(),
              iconPath: data?.lastIcon?.imagePath,
              eventFeedId: data?.feedId ?? '',
              fromFeed: true,
            ),
            const SizedBox(
              width: 10,
            ),
            Visibility(
              visible: data?.getFeedType() != FeedType.advancedEvent,
              child: WButtonInkwell(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.routeCommentListScreen,
                    arguments: CommentArgs(
                      title: 'Comments',
                      itemId: int.parse(data?.feedId ?? ''),
                      eventFeedId: fromEventFeed! ? int.parse(data?.feedId ?? '') : 0,
                      commentType: fromEventFeed! ? CommentType.eventFeed : CommentType.home,
                      data: null,
                    ),
                  );
                },
                child: _buildIcon(
                  SvgPicture.asset(AppAssets.commentIcon),
                  data?.totalComment ?? '0',
                  context,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildIcon(Widget icon, String value, BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
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
      ),
    );
  }
}
