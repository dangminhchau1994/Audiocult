import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_delete.dart';
import 'package:audio_cult/w_components/comment/comment_edit.dart';
import 'package:audio_cult/w_components/comment/comment_input.dart';
import 'package:audio_cult/w_components/comment/comment_list_screen.dart';
import 'package:audio_cult/w_components/comment/reply_list.dart';
import 'package:audio_cult/w_components/comment/reply_list_bloc.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../app/constants/global_constants.dart';
import '../../app/data_source/models/requests/comment_request.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../../app/features/events/detail/event_detail_bloc.dart';
import '../../app/features/music/detail-song/detail_song_bloc.dart';
import '../../app/features/music/detail_album/detail_album_bloc.dart';
import '../../app/features/music/detail_playlist/detail_playlist_bloc.dart';
import '../../app/utils/constants/app_colors.dart';
import '../../app/utils/route/app_route.dart';
import '../../di/bloc_locator.dart';
import '../appbar/common_appbar.dart';

class ReplyListScreen extends StatefulWidget {
  const ReplyListScreen({
    Key? key,
    required this.commentArgs,
  }) : super(key: key);

  final CommentArgs commentArgs;

  @override
  State<ReplyListScreen> createState() => _ReplyListScreenState();
}

class _ReplyListScreenState extends State<ReplyListScreen> {
  final PagingController<int, CommentResponse> _pagingController = PagingController(firstPageKey: 1);
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<bool> _emojiShowing = ValueNotifier<bool>(false);
  final ValueNotifier<String> _text = ValueNotifier<String>('');
  late ReplyListBloc _replyListBloc;
  late FocusNode _focusNode;

  String getType() {
    final type = widget.commentArgs.commentType!;
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

  void _onEmojiSelected(Emoji emoji) {
    _textEditingController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length),
      );
    _text.value += _textEditingController.text;
  }

  void _onBackspacePressed() {
    _textEditingController
      ..text = _textEditingController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length),
      );
    _text.value = _textEditingController.text;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _replyListBloc = getIt.get<ReplyListBloc>();
    _replyListBloc.requestData(
      params: CommentRequest(
        parentId: int.parse(widget.commentArgs.data?.commentId ?? ''),
        id: widget.commentArgs.itemId,
        typeId: getType(),
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        sort: 'latest',
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _replyListBloc.loadData(
        CommentRequest(
          parentId: int.parse(widget.commentArgs.data?.commentId ?? ''),
          id: widget.commentArgs.itemId,
          typeId: getType(),
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          sort: 'latest',
        ),
      );
      newItems.fold(
        (l) {
          final isLastPage = l.length < GlobalConstants.loadMoreItem;
          if (isLastPage) {
            _pagingController.appendLastPage(l);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(l, nextPageKey);
          }
        },
        (r) => _replyListBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _clearText() {
    _text.value = '';
    _emojiShowing.value = false;
    _textEditingController.text = '';
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _reloadListComment() {
    switch (getType()) {
      case 'event':
        getIt<EventDetailBloc>().getEventDetail(widget.commentArgs.itemId ?? 0);
        break;
      case 'music_song':
        getIt<DetailSongBloc>().getSongDetail(widget.commentArgs.itemId ?? 0);
        break;
      case 'music_album':
        getIt<DetailAlbumBloc>().getAlbumDetail(widget.commentArgs.itemId ?? 0);
        break;
      case 'advancedmusic_playlist':
        getIt<DetailPlayListBloc>().getPlayListDetail(widget.commentArgs.itemId ?? 0);
        break;
      default:
    }
  }

  void _submitReply() {
    _replyListBloc.createReply(
      int.parse(widget.commentArgs.data?.commentId ?? ''),
      widget.commentArgs.itemId ?? 0,
      getType(),
      _text.value,
      feedId: getType() == 'feed' ? widget.commentArgs.itemId : 0,
    );

    //clear text
    _clearText();

    //reload list comment of previous screen
    _reloadListComment();

    //reload data
    _pagingController.refresh();
    _replyListBloc.requestData(
      params: CommentRequest(
        parentId: int.parse(widget.commentArgs.data?.commentId ?? ''),
        id: widget.commentArgs.itemId,
        typeId: getType(),
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        sort: 'latest',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
    _textEditingController.dispose();
    _text.dispose();
    _focusNode.dispose();
    _emojiShowing.dispose();
  }

  void _editComment(CommentResponse item) async {
    Navigator.pop(context);
    final result = await Navigator.pushNamed(
      context,
      AppRoute.routeCommentEdit,
      arguments: {
        'comment_response': item,
      },
    );
    if (result != null) {
      final comment = result as CommentResponse;
      _replyListBloc.editCommentItem(_pagingController, comment);
    }
  }

  void _deleteComment(CommentResponse item, int index) {
    Navigator.pop(context);
    _replyListBloc.deleteComment(int.parse(item.commentId ?? ''));
    _replyListBloc.deleteCommentItem(_pagingController, index);
  }

  void _showBottomSheet(CommentResponse item, int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 150,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.secondaryButtonColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            CommentEdit(
              onEdit: () {
                _editComment(item);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            CommentDelete(
              onDelete: () {
                _deleteComment(item, index);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        _emojiShowing.value = false;
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CommonAppBar(
          centerTitle: false,
          title: context.l10n.t_reply,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            ReplyList(
              pagingController: _pagingController,
              commentArgs: widget.commentArgs,
              replyListBloc: _replyListBloc,
              getType: getType(),
              showBottomSheet: _showBottomSheet,
              onFocus: () {
                _focusNode.requestFocus();
              },
            ),
            CommentInput(
              textEditingController: _textEditingController,
              text: _text,
              focusNode: _focusNode,
              emojiShowing: _emojiShowing,
              onEmojiSelected: _onEmojiSelected,
              onBackspacePressed: _onBackspacePressed,
              submitComment: _submitReply,
            )
          ],
        ),
      ),
    );
  }
}
