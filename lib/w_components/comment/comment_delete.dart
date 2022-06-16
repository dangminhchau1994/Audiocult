import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_list_bloc.dart';
import 'package:audio_cult/w_components/comment/reply_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../app/constants/global_constants.dart';
import '../../app/data_source/models/requests/comment_request.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../buttons/w_button_inkwell.dart';

class CommentDelete extends StatelessWidget {
  const CommentDelete({
    Key? key,
    this.commentListBloc,
    this.replyListBloc,
    this.pagingController,
    this.commentArgs,
    this.item,
    this.getType,
  }) : super(key: key);

  final PagingController<int, CommentResponse>? pagingController;
  final CommentListBloc? commentListBloc;
  final ReplyListBloc? replyListBloc;
  final CommentArgs? commentArgs;
  final CommentResponse? item;
  final String? getType;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: () {
        Navigator.pop(context);
        pagingController?.refresh();
        replyListBloc != null
            ? replyListBloc?.deleteComment(int.parse(item?.commentId ?? ''))
            : commentListBloc?.deleteComment(int.parse(item?.commentId ?? ''));
        commentListBloc?.requestData(
          params: CommentRequest(
            id: commentArgs?.itemId ?? 0,
            typeId: getType,
            page: 1,
            limit: GlobalConstants.loadMoreItem,
            sort: 'latest',
          ),
        );
      },
      child: Row(
        children: [
          const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            context.l10n.t_delete,
            style: context.buttonTextStyle()!.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
