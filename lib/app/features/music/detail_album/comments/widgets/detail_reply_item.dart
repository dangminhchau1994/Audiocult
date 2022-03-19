import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/features/music/detail_album/comments/detail_list_album_comment_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../w_components/error_empty/error_section.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/route/app_route.dart';
import '../../detail_comment_args.dart';

class DetailReplyItem extends StatefulWidget {
  const DetailReplyItem({
    Key? key,
    this.parentId,
    this.id,
    this.commentParent,
  }) : super(key: key);

  final int? parentId;
  final int? id;
  final CommentResponse? commentParent;

  @override
  State<DetailReplyItem> createState() => _DetailReplyItemState();
}

class _DetailReplyItemState extends State<DetailReplyItem> {
  final DetailListAlbumCommentBloc _detailListAlbumCommentBloc = DetailListAlbumCommentBloc(locator.get());

  @override
  void initState() {
    super.initState();
    _detailListAlbumCommentBloc.getReplies(widget.parentId ?? 0, widget.id ?? 0, 'music_album', 1, 2);
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
        stream: _detailListAlbumCommentBloc.getRepliesStream,
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
                          AppRoute.routeDetailListAlbumReplies,
                          arguments: DetailCommentArgs(
                            data: widget.commentParent,
                            itemId: widget.id,
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            data[index].text ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: AppColors.lightWhiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
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
