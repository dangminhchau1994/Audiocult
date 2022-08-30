import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_bloc.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/comment/comment_item.dart';
import 'package:audio_cult/w_components/comment/comment_list_screen.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../../w_components/comment/comment_args.dart';
import '../../../../../w_components/comment/reply_item.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';

class DetailSongComment extends StatefulWidget {
  const DetailSongComment({
    Key? key,
    this.id,
    this.title,
  }) : super(key: key);

  final int? id;
  final String? title;

  @override
  State<DetailSongComment> createState() => _DetailSongCommentState();
}

class _DetailSongCommentState extends State<DetailSongComment> {
  DetailSongBloc songBloc = DetailSongBloc(locator.get(), locator.get<MyCartBloc>());

  @override
  void initState() {
    songBloc.getComments(widget.id ?? 0, 'music_song', 1, 3, 'latest');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              maxLines: 5,
              cursorColor: Colors.white,
              onChanged: (value) {},
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.routeCommentListScreen,
                  arguments: CommentArgs(
                    itemId: widget.id ?? 0,
                    title: widget.title ?? '',
                    commentType: CommentType.song,
                    data: null,
                  ),
                );
              },
              decoration: InputDecoration(
                filled: true,
                focusColor: AppColors.outlineBorderColor,
                fillColor: AppColors.secondaryButtonColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: AppColors.outlineBorderColor,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: AppColors.outlineBorderColor,
                    width: 2,
                  ),
                ),
                hintText: context.localize.t_leave_comment,
                hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                      color: AppColors.subTitleColor,
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<BlocState<List<CommentResponse>>>(
              initialData: const BlocState.loading(),
              stream: songBloc.getCommentsStream,
              builder: (context, snapshot) {
                final state = snapshot.data!;

                return state.when(
                  success: (success) {
                    final data = success as List<CommentResponse>;

                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          'No comments for this song',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(height: 30),
                          itemBuilder: (context, index) {
                            return ExpandablePanel(
                              controller: ExpandableController(initialExpanded: true),
                              header: CommentItem(
                                data: data[index],
                                onReply: (data) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoute.routeReplyListScreen,
                                    arguments: CommentArgs(
                                      data: data,
                                      itemId: widget.id,
                                      commentType: CommentType.song,
                                    ),
                                  );
                                },
                              ),
                              theme: const ExpandableThemeData(
                                hasIcon: false,
                                tapBodyToExpand: false,
                                useInkWell: false,
                                tapHeaderToExpand: false,
                              ),
                              collapsed: Container(),
                              expanded: ReplyItem(
                                parentId: int.parse(data[index].commentId ?? ''),
                                id: widget.id,
                                commentParent: data[index],
                                commentType: CommentType.song,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (data.isEmpty)
                          const SizedBox()
                        else
                          WButtonInkwell(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeCommentListScreen,
                                arguments: CommentArgs(
                                  itemId: widget.id ?? 0,
                                  title: widget.title ?? '',
                                  commentType: CommentType.song,
                                  data: null,
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                context.localize.t_view_more_comment,
                                style: context.bodyTextPrimaryStyle()!.copyWith(
                                      color: AppColors.lightBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          )
                      ],
                    );
                  },
                  loading: () {
                    return const Center(
                      child: LoadingWidget(),
                    );
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
              height: 20,
            ),
            Container(
              width: double.infinity,
              color: AppColors.secondaryButtonColor,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
