import 'dart:io';

import 'package:audio_cult/app/features/music/detail_album/detail_comment_args.dart';
import 'package:audio_cult/app/features/music/detail_album/replies/detail_list_album_replies_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/appbar/common_appbar.dart';
import '../../../../../w_components/comment/common_comment.dart';
import '../../../../../w_components/loading/loading_builder.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../constants/global_constants.dart';
import '../../../../data_source/models/requests/comment_request.dart';
import '../../../../data_source/models/responses/comment/comment_response.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';

class DetailListRepliesScreen extends StatefulWidget {
  const DetailListRepliesScreen({
    Key? key,
    this.detailCommentArgs,
  }) : super(key: key);

  final DetailCommentArgs? detailCommentArgs;

  @override
  State<DetailListRepliesScreen> createState() => _DetailListRepliesScreenState();
}

class _DetailListRepliesScreenState extends State<DetailListRepliesScreen> {
  final PagingController<int, CommentResponse> _pagingController = PagingController(firstPageKey: 1);
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<bool> _emojiShowing = ValueNotifier<bool>(false);
  final ValueNotifier<String> _text = ValueNotifier<String>('');
  late DetailListAlbumRepliesBloc _detailListAlbumRepliesBloc;
  late FocusNode _focusNode;

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
    _detailListAlbumRepliesBloc = getIt.get<DetailListAlbumRepliesBloc>();
    _detailListAlbumRepliesBloc.requestData(
      params: CommentRequest(
        parentId: int.parse(widget.detailCommentArgs?.data?.commentId ?? ''),
        id: widget.detailCommentArgs?.itemId,
        typeId: 'music_album',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _detailListAlbumRepliesBloc.loadData(
        CommentRequest(
          parentId: int.parse(widget.detailCommentArgs?.data?.commentId ?? ''),
          id: widget.detailCommentArgs?.itemId,
          typeId: 'music_album',
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
        (r) => _detailListAlbumRepliesBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _submitReply() {
    _detailListAlbumRepliesBloc.createReply(int.parse(widget.detailCommentArgs?.data?.commentId ?? ''),
        widget.detailCommentArgs?.itemId ?? 0, 'music_album', _text.value);
    _text.value = '';
    _emojiShowing.value = false;
    _textEditingController.text = '';
    FocusManager.instance.primaryFocus?.unfocus();
    _pagingController.refresh();
    _detailListAlbumRepliesBloc.requestData(
      params: CommentRequest(
        parentId: int.parse(widget.detailCommentArgs?.data?.commentId ?? ''),
        id: widget.detailCommentArgs?.itemId,
        typeId: 'music_album',
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
                      header: CommonComment(
                        data: widget.detailCommentArgs?.data,
                        onReply: (data) {},
                      ),
                      collapsed: Container(),
                      expanded: LoadingBuilder<DetailListAlbumRepliesBloc, List<CommentResponse>>(
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
                                  return CommonComment(
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
                          _detailListAlbumRepliesBloc.requestData(
                            params: CommentRequest(
                              parentId: int.parse(widget.detailCommentArgs?.data?.commentId ?? ''),
                              id: widget.detailCommentArgs?.itemId,
                              typeId: 'music_album',
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
