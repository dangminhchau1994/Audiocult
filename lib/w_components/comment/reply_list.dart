import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_item.dart';
import 'package:audio_cult/w_components/comment/reply_list_bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../app/constants/global_constants.dart';
import '../../app/data_source/models/requests/comment_request.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../../app/data_source/services/hive_service_provider.dart';
import '../buttons/w_button_inkwell.dart';
import '../loading/loading_builder.dart';
import '../loading/loading_widget.dart';

class ReplyList extends StatelessWidget {
  const ReplyList({
    Key? key,
    this.pagingController,
    this.commentArgs,
    this.replyListBloc,
    this.hiveServiceProvider,
    this.getType,
    this.commentResponse,
    this.showBottomSheet,
    this.onFocus,
  }) : super(key: key);

  final PagingController<int, CommentResponse>? pagingController;
  final CommentArgs? commentArgs;
  final ReplyListBloc? replyListBloc;
  final HiveServiceProvider? hiveServiceProvider;
  final String? getType;
  final ValueNotifier<CommentResponse>? commentResponse;
  final Function(CommentResponse item)? showBottomSheet;
  final Function()? onFocus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: kVerticalSpacing,
          horizontal: kHorizontalSpacing,
        ),
        child: ExpandableNotifier(
          controller: ExpandableController(initialExpanded: true),
          child: ScrollOnExpand(
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                hasIcon: false,
                tapHeaderToExpand: false,
                tapBodyToCollapse: false,
                tapBodyToExpand: false,
                useInkWell: false,
              ),
              header: CommentItem(
                data: commentArgs!.data,
                onReply: (data) {
                  onFocus!();
                },
              ),
              collapsed: Container(),
              expanded: LoadingBuilder<ReplyListBloc, List<CommentResponse>>(
                builder: (data, _) {
                  //only first page
                  final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
                  if (isLastPage) {
                    pagingController!.appendLastPage(data);
                  } else {
                    pagingController!.appendPage(data, pagingController!.firstPageKey + 1);
                  }
                  return Container(
                    height: 650,
                    padding: const EdgeInsets.only(bottom: 50, left: 40),
                    child: Scrollbar(
                      child: PagedListView<int, CommentResponse>.separated(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        pagingController: pagingController!,
                        separatorBuilder: (context, index) => const Divider(height: 24),
                        builderDelegate: PagedChildBuilderDelegate<CommentResponse>(
                          firstPageProgressIndicatorBuilder: (context) => Container(),
                          newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                          animateTransitions: true,
                          itemBuilder: (context, item, index) {
                            return WButtonInkwell(
                              onPressed: () {
                                if (hiveServiceProvider!.getProfile()?.userId == item.userId) {
                                  showBottomSheet!(item);
                                }
                              },
                              child: ValueListenableBuilder(
                                valueListenable: commentResponse!,
                                builder: (context, value, child) {
                                  return CommentItem(
                                    data: item,
                                    onReply: (data) {
                                      onFocus!();
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                reloadAction: (_) {
                  pagingController!.refresh();
                  replyListBloc!.requestData(
                    params: CommentRequest(
                      parentId: int.parse(commentArgs!.data?.commentId ?? ''),
                      id: commentArgs!.itemId,
                      typeId: getType,
                      page: 1,
                      limit: GlobalConstants.loadMoreItem,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
