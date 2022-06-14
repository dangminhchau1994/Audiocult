import 'dart:io';

import 'package:audio_cult/app/data_source/services/hive_service_provider.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_item.dart';
import 'package:audio_cult/w_components/comment/comment_list_bloc.dart';
import 'package:audio_cult/w_components/comment/reply_item.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../app/constants/global_constants.dart';
import '../../app/data_source/models/requests/comment_request.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../../app/features/events/detail/event_detail_bloc.dart';
import '../../app/features/music/detail-song/detail_song_bloc.dart';
import '../../app/features/music/detail_album/detail_album_bloc.dart';
import '../../app/features/music/detail_playlist/detail_playlist_bloc.dart';
import '../../app/utils/constants/app_assets.dart';
import '../../app/utils/constants/app_colors.dart';
import '../../app/utils/constants/app_dimens.dart';
import '../../app/utils/route/app_route.dart';
import '../../di/bloc_locator.dart';
import '../appbar/common_appbar.dart';
import '../loading/loading_builder.dart';
import '../loading/loading_widget.dart';

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
  final ValueNotifier<CommentResponse> _commentResponse = ValueNotifier<CommentResponse>(CommentResponse(text: ''));
  final HiveServiceProvider _hiveServiceProvider = HiveServiceProvider();
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

  void _showBottomSheet(CommentResponse item) {
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
            WButtonInkwell(
              onPressed: () async {
                Navigator.pop(context);
                final result = await Navigator.pushNamed(
                  context,
                  AppRoute.routeCommentEdit,
                  arguments: {
                    'comment_response': item,
                  },
                );
                if (result != null) {
                  _commentResponse.value = result as CommentResponse;
                  item = _commentResponse.value;
                }
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    context.l10n.t_edit,
                    style: context.buttonTextStyle()!.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            WButtonInkwell(
              onPressed: () {
                Navigator.pop(context);
                _pagingController.refresh();
                _commentListBloc.deleteComment(int.parse(item.commentId ?? ''));
                _commentListBloc.requestData(
                  params: CommentRequest(
                    id: widget.commentArgs.itemId ?? 0,
                    typeId: getType(),
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
            ),
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: kVerticalSpacing - 10,
                horizontal: kHorizontalSpacing - 10,
              ),
              child: RefreshIndicator(
                color: AppColors.primaryButtonColor,
                backgroundColor: AppColors.secondaryButtonColor,
                onRefresh: () async {
                  _pagingController.refresh();
                  _commentListBloc.requestData(
                    params: CommentRequest(
                      id: widget.commentArgs.itemId,
                      typeId: getType(),
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
                      _pagingController.appendLastPage(data);
                    } else {
                      _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
                    }
                    return Scrollbar(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 120),
                        child: PagedListView<int, CommentResponse>.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          pagingController: _pagingController,
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
                                    if (_hiveServiceProvider.getProfile()?.userId == item.userId) {
                                      _showBottomSheet(item);
                                    }
                                  },
                                  child: ValueListenableBuilder<CommentResponse>(
                                    valueListenable: _commentResponse,
                                    builder: (context, value, child) {
                                      return CommentItem(
                                        data: item,
                                        onReply: (data) {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoute.routeReplyListScreen,
                                            arguments: CommentArgs(
                                              data: data,
                                              commentType: widget.commentArgs.commentType,
                                              itemId: widget.commentArgs.itemId,
                                            ),
                                          );
                                        },
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
                                  id: widget.commentArgs.itemId,
                                  commentParent: item,
                                  commentType: widget.commentArgs.commentType,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  reloadAction: (_) {
                    _pagingController.refresh();
                    _commentListBloc.requestData(
                      params: CommentRequest(
                        id: widget.commentArgs.itemId,
                        typeId: getType(),
                        page: 1,
                        limit: GlobalConstants.loadMoreItem,
                        sort: 'latest',
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondaryButtonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      ValueListenableBuilder<String>(
                        valueListenable: _text,
                        builder: (context, value, child) => TextField(
                          cursorColor: Colors.white,
                          autofocus: true,
                          controller: _textEditingController,
                          onChanged: (value) {
                            _text.value = value;
                          },
                          onSubmitted: (value) {
                            if (_text.value.isNotEmpty) {
                              _submitComment();
                            }
                          },
                          onTap: () {
                            _emojiShowing.value = false;
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
                            suffixIcon: value.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _emojiShowing.value = !_emojiShowing.value;
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: SvgPicture.asset(
                                        AppAssets.faceIcon,
                                        width: 12,
                                        height: 12,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (_text.value.isNotEmpty) {
                                        _submitComment();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryButtonColor,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: AppColors.outlineBorderColor,
                                width: 2,
                              ),
                            ),
                            hintText: context.l10n.t_leave_comment,
                            hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: AppColors.subTitleColor,
                                ),
                          ),
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        builder: (context, value, child) => Offstage(
                          offstage: !value,
                          child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              onEmojiSelected: (Category category, Emoji emoji) {
                                _onEmojiSelected(emoji);
                              },
                              onBackspacePressed: _onBackspacePressed,
                              config: Config(
                                // Issue: https://github.com/flutter/flutter/issues/28894
                                emojiSizeMax: 18 * (Platform.isIOS ? 1.30 : 1.0),
                                bgColor: AppColors.secondaryButtonColor,
                              ),
                            ),
                          ),
                        ),
                        valueListenable: _emojiShowing,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
