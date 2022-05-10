import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_list_bloc.dart';
import 'package:audio_cult/w_components/comment/comment_list_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app/base/bloc_state.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../../app/utils/constants/app_colors.dart';
import '../../app/utils/constants/app_dimens.dart';
import '../../app/utils/route/app_route.dart';
import '../error_empty/error_section.dart';
import '../loading/loading_widget.dart';

class ReplyItem extends StatefulWidget {
  const ReplyItem({
    Key? key,
    this.parentId,
    this.id,
    this.commentParent,
    this.commentType,
  }) : super(key: key);

  final int? parentId;
  final int? id;
  final CommentType? commentType;
  final CommentResponse? commentParent;

  @override
  State<ReplyItem> createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  final CommentListBloc _commentListBloc = CommentListBloc(locator.get());

  @override
  void initState() {
    super.initState();
    _commentListBloc.getReplies(widget.parentId ?? 0, widget.id ?? 0, getType(), 1, 2, 'latest');
  }

  String getType() {
    final type = widget.commentType!;
    switch (type) {
      case CommentType.album:
        return 'music_album';
      case CommentType.playlist:
        return 'advanced_music_playlist';
      case CommentType.song:
        return 'music_song';
      case CommentType.event:
        return 'event';
      case CommentType.home:
        return 'feed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
        vertical: kVerticalSpacing,
      ),
      child: StreamBuilder<BlocState<List<CommentResponse>>>(
        initialData: const BlocState.loading(),
        stream: _commentListBloc.getRepliesStream,
        builder: (context, snapshot) {
          final state = snapshot.data!;

          return state.when(
            success: (success) {
              final data = success as List<CommentResponse>;

              return Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(height: 15),
                  shrinkWrap: true,
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.routeReplyListScreen,
                          arguments: CommentArgs(
                            data: widget.commentParent,
                            itemId: widget.id,
                            commentType: widget.commentType,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl: data[index].userImage ?? '',
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
                          Text(
                            data[index].userName ?? '',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: AppColors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              data[index].text ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.bodyTextPrimaryStyle()!.copyWith(
                                    color: AppColors.subTitleColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            loading: () {
              return const LoadingWidget();
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
    );
  }
}
