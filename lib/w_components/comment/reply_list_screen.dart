import 'dart:io';

import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/comment/comment_args.dart';
import 'package:audio_cult/w_components/comment/comment_item.dart';
import 'package:audio_cult/w_components/comment/comment_list_screen.dart';
import 'package:audio_cult/w_components/comment/reply_list_bloc.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../app/constants/app_text_styles.dart';
import '../../app/constants/global_constants.dart';
import '../../app/data_source/models/requests/comment_request.dart';
import '../../app/data_source/models/responses/comment/comment_response.dart';
import '../../app/utils/constants/app_assets.dart';
import '../../app/utils/constants/app_colors.dart';
import '../../app/utils/constants/app_dimens.dart';
import '../../di/bloc_locator.dart';
import '../appbar/common_appbar.dart';
import '../loading/loading_builder.dart';
import '../loading/loading_widget.dart';

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
      case CommentType.home:
        return '';
      case CommentType.sonng:
        return '';
      case CommentType.playlist:
        return '';
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

  void _submitReply() {
    _replyListBloc.createReply(
      int.parse(widget.commentArgs.data?.commentId ?? ''),
      widget.commentArgs.itemId ?? 0,
      getType(),
      _text.value,
    );
    _text.value = '';
    _emojiShowing.value = false;
    _textEditingController.text = '';
    FocusManager.instance.primaryFocus?.unfocus();
    _pagingController.refresh();
    _replyListBloc.requestData(
      params: CommentRequest(
        parentId: int.parse(widget.commentArgs.data?.commentId ?? ''),
        id: widget.commentArgs.itemId,
        typeId: getType(),
        page: 1,
        limit: GlobalConstants.loadMoreItem,
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
            SingleChildScrollView(
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
                        tapBodyToExpand: false,
                        useInkWell: false,
                      ),
                      header: CommentItem(
                        data: widget.commentArgs.data,
                        onReply: (data) {
                          _focusNode.requestFocus();
                        },
                      ),
                      collapsed: Container(),
                      expanded: LoadingBuilder<ReplyListBloc, List<CommentResponse>>(
                        builder: (data, _) {
                          //only first page
                          final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
                          if (isLastPage) {
                            _pagingController.appendLastPage(data);
                          } else {
                            _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
                          }
                          return Container(
                            height: 650,
                            padding: const EdgeInsets.only(bottom: 50, left: 40),
                            child: PagedListView<int, CommentResponse>.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              pagingController: _pagingController,
                              separatorBuilder: (context, index) => const Divider(height: 24),
                              builderDelegate: PagedChildBuilderDelegate<CommentResponse>(
                                firstPageProgressIndicatorBuilder: (context) => Container(),
                                newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                                animateTransitions: true,
                                itemBuilder: (context, item, index) {
                                  return CommentItem(
                                    data: item,
                                    onReply: (data) {
                                      _focusNode.requestFocus();
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        reloadAction: (_) {
                          _pagingController.refresh();
                          _replyListBloc.requestData(
                            params: CommentRequest(
                              parentId: int.parse(widget.commentArgs.data?.commentId ?? ''),
                              id: widget.commentArgs.itemId,
                              typeId: getType(),
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
                          focusNode: _focusNode,
                          autofocus: true,
                          controller: _textEditingController,
                          onChanged: (value) {
                            _text.value = value;
                          },
                          onSubmitted: (value) {
                            if (_text.value.isNotEmpty) {
                              _submitReply();
                            }
                          },
                          onTap: () {
                            _emojiShowing.value = false;
                          },
                          style: AppTextStyles.normal,
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
                                        _submitReply();
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
                                  color: AppColors.lightWhiteColor,
                                  fontSize: 14,
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
