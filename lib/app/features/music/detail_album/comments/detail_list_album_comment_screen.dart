import 'dart:io';

import 'package:audio_cult/app/data_source/models/requests/comment_request.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/features/music/detail_album/comments/detail_list_album_comment_bloc.dart';
import 'package:audio_cult/app/features/music/detail_album/comments/widgets/detail_reply_item.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_args.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_comment_args.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/comment/common_comment.dart';
import '../../../../../w_components/loading/loading_builder.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../constants/global_constants.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';

class DetailListAlbumCommentScreen extends StatefulWidget {
  const DetailListAlbumCommentScreen({
    Key? key,
    required this.detailAlbumArgs,
  }) : super(key: key);

  final DetailAlbumArgs detailAlbumArgs;

  @override
  State<DetailListAlbumCommentScreen> createState() => _DetailListAlbumScreenState();
}

class _DetailListAlbumScreenState extends State<DetailListAlbumCommentScreen> {
  final PagingController<int, CommentResponse> _pagingController = PagingController(firstPageKey: 1);
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<bool> _emojiShowing = ValueNotifier<bool>(false);
  final ValueNotifier<String> _text = ValueNotifier<String>('');
  late DetailListAlbumCommentBloc _detailListAlbumCommentBloc;

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

  void _submitComment() {
    _detailListAlbumCommentBloc.createComment(widget.detailAlbumArgs.albumId, 'music_album', _text.value);
    _text.value = '';
    _emojiShowing.value = false;
    _textEditingController.text = '';
    FocusManager.instance.primaryFocus?.unfocus();
    _pagingController.refresh();
    _detailListAlbumCommentBloc.requestData(
      params: CommentRequest(
        id: widget.detailAlbumArgs.albumId,
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
    _emojiShowing.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _detailListAlbumCommentBloc = getIt.get<DetailListAlbumCommentBloc>();
    _detailListAlbumCommentBloc.requestData(
      params: CommentRequest(
        id: widget.detailAlbumArgs.albumId,
        typeId: 'music_album',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _detailListAlbumCommentBloc.loadData(
        CommentRequest(
          id: widget.detailAlbumArgs.albumId,
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
        (r) => _detailListAlbumCommentBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
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
          title: widget.detailAlbumArgs.title,
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
                  _detailListAlbumCommentBloc.requestData(
                    params: CommentRequest(
                      id: widget.detailAlbumArgs.albumId,
                      typeId: 'music_album',
                      page: 1,
                      limit: GlobalConstants.loadMoreItem,
                    ),
                  );
                },
                child: LoadingBuilder<DetailListAlbumCommentBloc, List<CommentResponse>>(
                  builder: (data, _) {
                    //only first page
                    final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
                    if (isLastPage) {
                      _pagingController.appendLastPage(data);
                    } else {
                      _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
                    }
                    return Padding(
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
                              header: CommonComment(
                                data: item,
                                onReply: (data) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoute.routeDetailListAlbumReplies,
                                    arguments: DetailCommentArgs(
                                      data: data,
                                      itemId: widget.detailAlbumArgs.albumId,
                                    ),
                                  );
                                },
                              ),
                              theme: const ExpandableThemeData(
                                hasIcon: false,
                                tapBodyToExpand: false,
                                useInkWell: false,
                              ),
                              collapsed: Container(),
                              expanded: DetailReplyItem(
                                parentId: int.parse(item.commentId ?? ''),
                                id: widget.detailAlbumArgs.albumId,
                                commentParent: item,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  reloadAction: (_) {
                    _pagingController.refresh();
                    _detailListAlbumCommentBloc.requestData(
                      params: CommentRequest(
                        id: widget.detailAlbumArgs.albumId,
                        typeId: 'music_album',
                        page: 1,
                        limit: GlobalConstants.loadMoreItem,
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
