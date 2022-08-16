import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_item.dart';
import 'package:audio_cult/w_components/comment/comment_list_bloc.dart';
import 'package:audio_cult/w_components/comment/reply_item.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../app/constants/global_constants.dart';
import '../../app/data_source/models/requests/comment_request.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../../app/utils/route/app_route.dart';
import '../buttons/w_button_inkwell.dart';
import '../loading/loading_builder.dart';
import '../loading/loading_widget.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    Key? key,
    this.pagingController,
    this.commentArgs,
    this.commentListBloc,
    this.getType,
    this.showBottomSheet,
  }) : super(key: key);

  final PagingController<int, CommentResponse>? pagingController;
  final CommentArgs? commentArgs;
  final CommentListBloc? commentListBloc;
  final String? getType;
  final Function(CommentResponse item, int index)? showBottomSheet;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: kVerticalSpacing - 10,
        horizontal: kHorizontalSpacing - 10,
      ),
      child: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          pagingController?.refresh();
          commentListBloc?.requestData(
            params: CommentRequest(
              id: commentArgs?.itemId,
              typeId: getType,
              page: 1,
              limit: GlobalConstants.loadMoreItem,
              sort: 'latest',
            ),
          );
        },
        child: LoadingBuilder<CommentListBloc, List<CommentResponse>>(
          builder: (data, _) {
            //only first page
            final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
            if (isLastPage) {
              pagingController?.appendLastPage(data);
            } else {
              pagingController?.appendPage(data, pagingController!.firstPageKey + 1);
            }
            return Scrollbar(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: StreamBuilder<PagingController<int, CommentResponse>>(
                    initialData: pagingController,
                    stream: commentListBloc?.pagingControllerStream,
                    builder: (context, snapshot) => PagedListView<int, CommentResponse>.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      pagingController: snapshot.data!,
                      separatorBuilder: (context, index) => const Divider(height: 24),
                      builderDelegate: PagedChildBuilderDelegate<CommentResponse>(
                        firstPageProgressIndicatorBuilder: (context) => Container(),
                        newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                        animateTransitions: true,
                        itemBuilder: (context, item, index) {
                          return ExpandablePanel(
                            controller: ExpandableController(initialExpanded: true),
                            header: WButtonInkwell(
                              onPressed: () {
                                if (locator<PrefProvider>().currentUserId == item.userId) {
                                  showBottomSheet!(item, index);
                                }
                              },
                              child: CommentItem(
                                data: item,
                                reportType: commentArgs?.reportType,
                                itemId: commentArgs?.itemId,
                                onReply: (data) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoute.routeReplyListScreen,
                                    arguments: CommentArgs(
                                      data: data,
                                      reportType: commentArgs?.reportType,
                                      commentType: commentArgs?.commentType,
                                      itemId: commentArgs?.itemId,
                                    ),
                                  );
                                },
                              ),
                            ),
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                              tapHeaderToExpand: false,
                              tapBodyToCollapse: false,
                              tapBodyToExpand: false,
                              useInkWell: false,
                            ),
                            collapsed: Container(),
                            expanded: ReplyItem(
                              parentId: int.parse(item.commentId ?? ''),
                              id: commentArgs?.itemId,
                              commentParent: item,
                              commentType: commentArgs?.commentType,
                            ),
                          );
                        },
                      ),
                    ),
                  )),
            );
          },
          reloadAction: (_) {
            pagingController?.refresh();
            commentListBloc?.requestData(
              params: CommentRequest(
                id: commentArgs?.itemId,
                typeId: getType,
                page: 1,
                limit: GlobalConstants.loadMoreItem,
                sort: 'latest',
              ),
            );
          },
        ),
      ),
    );
  }
}
