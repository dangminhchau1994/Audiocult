import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/comment/comment_item_bloc.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_colors.dart';

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
  @override
  void initState() {
    getIt.get<CommentItemBloc>().getReactionIcons();
    super.initState();
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
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.data?.userName ?? '',
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.lightBlue,
                            fontWeight: FontWeight.bold,
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
                        Text(
                          DateTimeUtils.convertToAgo(int.parse(widget.data?.timeStamp ?? '')),
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.subTitleColor,
                              ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onReply!(widget.data!);
                          },
                          child: Text(
                            'Reply',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: Colors.lightBlue,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StreamBuilder<BlocState<List<ReactionIconResponse>>>(
                          initialData: const BlocState.loading(),
                          stream: getIt<CommentItemBloc>().getReactionIconStream,
                          builder: (context, snapshot) {
                            final state = snapshot.data!;

                            return state.when(
                              success: (success) {
                                final data = success as List<ReactionIconResponse>;
                                var reactions = <Reaction<ReactionIconResponse>>[];
                                reactions = data
                                    .map(
                                      (e) => Reaction<ReactionIconResponse>(
                                        value: e,
                                        title: _buildTitle(e.name ?? ''),
                                        icon: _buildReactionsIcon(
                                          e.imagePath ?? '',
                                        ),
                                      ),
                                    )
                                    .toList();

                                return ReactionButtonToggle<ReactionIconResponse>(
                                  boxPosition: Position.BOTTOM,
                                  boxPadding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  boxColor: AppColors.secondaryButtonColor,
                                  onReactionChanged: (ReactionIconResponse? value, bool isChecked) {
                                    getIt.get<CommentItemBloc>().postReactionIcon(
                                          'feed_mini',
                                          int.parse(widget.data?.commentId ?? ''),
                                          int.parse(value?.iconId ?? ''),
                                        );
                                  },
                                  reactions: reactions,
                                  initialReaction: Reaction<ReactionIconResponse>(
                                    value: ReactionIconResponse(),
                                    icon: SvgPicture.network(
                                      widget.data?.lastIcon?.imagePath ?? data[0].imagePath!,
                                      height: 25,
                                      width: 25,
                                      placeholderBuilder: (BuildContext context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  selectedReaction: reactions[0],
                                );
                              },
                              loading: () {
                                return Container();
                              },
                              error: (error) {
                                return ErrorSectionWidget(
                                  errorMessage: error,
                                  onRetryTap: () {},
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.data?.totalLike ?? '',
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.subTitleColor,
                              ),
                        ),
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
  return Text(
    title,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _buildReactionsIcon(String path) {
  return SvgPicture.network(
    path,
    height: 25,
    width: 25,
    placeholderBuilder: (BuildContext context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
