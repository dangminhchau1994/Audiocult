import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/comment/comment_args.dart';
import '../../../../w_components/comment/comment_item.dart';
import '../../../../w_components/comment/comment_list_screen.dart';
import '../../../../w_components/comment/reply_item.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../utils/route/app_route.dart';

class FeedItemComment extends StatelessWidget {
  const FeedItemComment({
    Key? key,
    this.homeBloc,
    this.feedId,
  }) : super(key: key);

  final HomeBloc? homeBloc;
  final String? feedId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState<List<CommentResponse>>>(
      initialData: const BlocState.loading(),
      stream: homeBloc?.getCommentsStream,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        return state.when(
          success: (success) {
            final data = success as List<CommentResponse>;

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
                              itemId: int.parse(feedId ?? ''),
                              commentType: CommentType.home,
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
                        id: int.parse(feedId ?? ''),
                        commentParent: data[index],
                        commentType: CommentType.home,
                      ),
                    );
                  },
                ),
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
    );
  }
}
