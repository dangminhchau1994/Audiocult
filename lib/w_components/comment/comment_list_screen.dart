import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_delete.dart';
import 'package:audio_cult/w_components/comment/comment_edit.dart';
import 'package:audio_cult/w_components/comment/comment_input.dart';
import 'package:audio_cult/w_components/comment/comment_list.dart';
import 'package:audio_cult/w_components/comment/comment_list_bloc.dart';
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

enum CommentType {
  home,
  song,
  album,
  playlist,
  event,
}

class CommentListScreen extends StatefulWidget {
  const CommentListScreen({
    Key? key,
    required this.commentArgs,
  }) : super(key: key);

  final CommentArgs commentArgs;

  @override
  State<CommentListScreen> createState() => _CommentListScreenState();
}

class _CommentListScreenState extends State<CommentListScreen> {
  final PagingController<int, CommentResponse> _pagingController = PagingController(firstPageKey: 1);
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<bool> _emojiShowing = ValueNotifier<bool>(false);
  final ValueNotifier<String> _text = ValueNotifier<String>('');
  late CommentListBloc _commentListBloc;

  String getType() {
    final type = widget.commentArgs.commentType!;
    switch (type) {
      case CommentType.album:
        return 'music_album';
      case CommentType.playlist:
        return 'advancedmusic_playlist';
      case CommentType.song:
        return 'music_song';
      case CommentType.home:
        return 'feed';
      case CommentType.event:
        return 'event';
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

  void _submitComment() {
    _commentListBloc.createComment(
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
    _commentListBloc.requestData(
      params: CommentRequest(
        id: widget.commentArgs.itemId ?? 0,
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
    _emojiShowing.dispose();
  }

  @override
  void initState() {
    super.initState();
    getType();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _commentListBloc = getIt.get<CommentListBloc>();
    _commentListBloc.requestData(
      params: CommentRequest(
        id: widget.commentArgs.itemId ?? 0,
        typeId: getType(),
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        sort: 'latest',
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _commentListBloc.loadData(
        CommentRequest(
          id: widget.commentArgs.itemId ?? 0,
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
        (r) => _commentListBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
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
      setState(() {
        _pagingController.itemList![
            _pagingController.itemList!.indexWhere((element) => element.commentId == comment.commentId)] = comment;
      });
    }
  }

  void _deleteComment(CommentResponse item, int index) {
    Navigator.pop(context);
    _commentListBloc.deleteComment(int.parse(item.commentId ?? ''));
    setState(() {
      _pagingController.itemList?.removeAt(index);
    });
  }

  void _showBottomSheet(CommentResponse item, int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 120,
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
          title: widget.commentArgs.title,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            CommentList(
              pagingController: _pagingController,
              commentArgs: widget.commentArgs,
              commentListBloc: _commentListBloc,
              getType: getType(),
              showBottomSheet: _showBottomSheet,
            ),
            CommentInput(
              textEditingController: _textEditingController,
              text: _text,
              emojiShowing: _emojiShowing,
              onEmojiSelected: _onEmojiSelected,
              onBackspacePressed: _onBackspacePressed,
              submitComment: _submitComment,
            )
          ],
        ),
      ),
    );
  }
}
