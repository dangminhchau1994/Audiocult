import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/comment/comment_item_bloc.dart';
import 'package:audio_cult/w_components/dialogs/report_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import '../../app/data_source/services/hive_service_provider.dart';
import '../../app/features/profile/profile_screen.dart';
import '../../app/utils/constants/app_colors.dart';
import '../../app/utils/route/app_route.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    Key? key,
    this.data,
    this.onReply,
  }) : super(key: key);

  final CommentResponse? data;
  final Function(CommentResponse data)? onReply;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  final _bloc = CommentItemBloc(locator.get());
  var reactions = <Reaction<ReactionIconResponse>>[];

  @override
  void initState() {
    super.initState();
    reactions = locator<HiveServiceProvider>()
        .getReactions()
        .map(
          (e) => Reaction<ReactionIconResponse>(
            value: e,
            icon: _buildReactionsIcon(
              e.imagePath ?? '',
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.routeProfile,
                  arguments: ProfileScreen.createArguments(id: widget.data!.userId!));
            },
            child: CachedNetworkImage(
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
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.routeProfile,
                            arguments: ProfileScreen.createArguments(id: widget.data!.userId!));
                      },
                      child: Text(
                        widget.data?.userName ?? '',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: AppColors.lightBlue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateTimeUtils.formatCommonDate('hh:mm', int.parse(widget.data?.timeStamp ?? '')),
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.subTitleColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.data?.text ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        WButtonInkwell(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                content: Builder(
                                  builder: (context) => ReportDialog(
                                    type: ReportType.comment,
                                    itemId: int.parse(widget.data?.commentId ?? ''),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            context.localize.t_report,
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: Colors.lightBlue,
                                ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        WButtonInkwell(
                          onPressed: () {
                            widget.onReply!(widget.data!);
                          },
                          child: Text(
                            'Reply',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: Colors.lightBlue,
                                ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                          DateTimeUtils.convertToAgo(int.parse(widget.data?.timeStamp ?? '')),
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.subTitleColor,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ReactionButtonToggle<ReactionIconResponse>(
                          boxPosition: Position.BOTTOM,
                          boxPadding: const EdgeInsets.all(12),
                          boxColor: AppColors.secondaryButtonColor,
                          onReactionChanged: (ReactionIconResponse? value, bool isChecked) {
                            _bloc.postReactionIcon(
                              'feed_mini',
                              int.parse(widget.data?.commentId ?? ''),
                              int.parse(value?.iconId ?? ''),
                            );
                          },
                          reactions: reactions,
                          initialReaction: Reaction<ReactionIconResponse>(
                            value: ReactionIconResponse(),
                            icon: SvgPicture.network(
                              widget.data?.lastIcon?.imagePath ??
                                  locator<HiveServiceProvider>().getReactions()[0].imagePath!,
                              height: 30,
                              width: 30,
                              placeholderBuilder: (BuildContext context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          selectedReaction: reactions[0],
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        StreamBuilder<String>(
                          initialData: widget.data?.totalLike ?? '',
                          stream: _bloc.postReactionIconStream,
                          builder: (context, snapshot) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              snapshot.data!,
                              style: context
                                  .bodyTextPrimaryStyle()!
                                  .copyWith(color: AppColors.subTitleColor, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildTitle(String title) {
  return SizedBox(
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );
}

Widget _buildReactionsIcon(String path) {
  return SvgPicture.network(
    path,
    height: 30,
    width: 30,
    placeholderBuilder: (BuildContext context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
