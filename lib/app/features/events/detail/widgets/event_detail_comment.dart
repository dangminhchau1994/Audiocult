import 'package:audio_cult/app/features/events/detail/event_detail_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../../w_components/comment/comment_args.dart';
import '../../../../../w_components/comment/comment_item.dart';
import '../../../../../w_components/comment/comment_list_screen.dart';
import '../../../../../w_components/comment/reply_item.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../../../../data_source/models/responses/comment/comment_response.dart';
import '../../../../injections.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';

class EventDetailComment extends StatefulWidget {
  const EventDetailComment({
    Key? key,
    this.id,
    this.title,
  }) : super(key: key);

  final int? id;
  final String? title;

  @override
  State<EventDetailComment> createState() => _EventDetailCommentState();
}

class _EventDetailCommentState extends State<EventDetailComment> {
  final EventDetailBloc _eventDetailBloc = EventDetailBloc(locator.get());

  @override
  void initState() {
    _eventDetailBloc.getComments(widget.id ?? 0, 'event', 1, 3, 'latest');
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
              maxLines: 3,
              showCursor: false, //add this line
              readOnly: true,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.routeCommentListScreen,
                  arguments: CommentArgs(
                    itemId: widget.id ?? 0,
                    title: widget.title ?? '',
                    commentType: CommentType.event,
                    data: null,
                  ),
                );
              },
              cursorColor: Colors.white,
              onChanged: (value) {},
              style: const TextStyle(fontSize: 20),
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
                      fontSize: 14,
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<BlocState<List<CommentResponse>>>(
              initialData: const BlocState.loading(),
              stream: _eventDetailBloc.getCommentsStream,
              builder: (context, snapshot) {
                final state = snapshot.data!;

                return state.when(
                  success: (success) {
                    final data = success as List<CommentResponse>;

                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          'No comments for this event',
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
                                      commentType: CommentType.event,
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
                                commentType: CommentType.event,
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
                                  commentType: CommentType.event,
                                  data: null,
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                context.localize.t_view_more_comment,
                                style: context.bodyTextPrimaryStyle()!.copyWith(
                                      color: AppColors.lightBlue,
                                      fontSize: 14,
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
