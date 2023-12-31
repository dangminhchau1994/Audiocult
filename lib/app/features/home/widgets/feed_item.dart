import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/features/home/widgets/feed_item_content.dart';
import 'package:audio_cult/app/features/home/widgets/feed_item_interaction.dart';
import 'package:audio_cult/app/features/home/widgets/feed_item_modify.dart';
import 'package:audio_cult/app/features/home/widgets/feed_item_user_info.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import '../../../../w_components/comment/comment_args.dart';
import '../../../../w_components/comment/comment_list_screen.dart';
import '../../../utils/route/app_route.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({
    Key? key,
    this.data,
    this.onDelete,
    this.onEdit,
    this.fromEventFeed = false,
    this.onReport,
  }) : super(key: key);

  final FeedResponse? data;
  final Function()? onDelete;
  final bool? fromEventFeed;
  final Function()? onEdit;
  final Function()? onReport;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 28,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondaryButtonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeedItemUserInfo(
                data: widget.data,
              ),
              const SizedBox(height: 20),
              FeedItemContent(
                data: widget.data,
              ),
              const SizedBox(height: 20),
              FeedItemInteraction(
                data: widget.data,
                fromEventFeed: widget.fromEventFeed,
              ),
            ],
          ),
        ),
        FeedItemModify(
          item: widget.data,
          onDelete: widget.onDelete,
          onEdit: widget.onEdit,
          onReport: widget.onReport,
        ),
      ],
    );
  }
}
