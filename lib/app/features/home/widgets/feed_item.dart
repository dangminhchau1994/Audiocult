import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/comment/comment_args.dart';
import '../../../../w_components/comment/comment_item.dart';
import '../../../../w_components/comment/comment_list_screen.dart';
import '../../../../w_components/comment/reply_item.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/datetime/date_time_utils.dart';
import '../../../utils/route/app_route.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({Key? key, this.data}) : super(key: key);

  final FeedResponse? data;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  final HomeBloc _homeBloc = HomeBloc(locator.get());

  @override
  void initState() {
    _homeBloc.getComments(int.parse(widget.data?.feedId ?? ''), 'feed', 1, 3, 'latest');
    getIt.get<HomeBloc>().getReactionIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondaryButtonColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: widget.data?.userImage ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryButtonColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.data?.userName ?? ''} ${widget.data?.feedInfo ?? ''}',
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateTimeUtils.convertToAgo(int.parse(widget.data?.timeStamp ?? '')),
                        style: context.buttonTextStyle()!.copyWith(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              _buildBody(widget.data!.getFeedType()),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildIcon(
                        SvgPicture.asset(AppAssets.heartIcon),
                        widget.data!.feedTotalLike.toString(),
                        context,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      WButtonInkwell(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.routeCommentListScreen,
                            arguments: CommentArgs(
                              itemId: int.parse(widget.data?.feedId ?? ''),
                              title: 'Comments',
                              commentType: CommentType.home,
                              data: null,
                            ),
                          );
                        },
                        child: _buildIcon(
                          SvgPicture.asset(AppAssets.commentIcon),
                          widget.data?.totalComment ?? '',
                          context,
                        ),
                      )
                    ],
                  ),
                  _buildViewCount(widget.data?.totalView ?? '', context)
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 0.5, color: Colors.grey),
              const SizedBox(height: 20),
              StreamBuilder<BlocState<List<CommentResponse>>>(
                initialData: const BlocState.loading(),
                stream: _homeBloc.getCommentsStream,
                builder: (context, snapshot) {
                  final state = snapshot.data!;

                  return state.when(
                    success: (success) {
                      final data = success as List<CommentResponse>;

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
                                        itemId: int.parse(widget.data?.feedId ?? ''),
                                        commentType: CommentType.home,
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
                                  id: int.parse(widget.data?.feedId ?? ''),
                                  commentParent: data[index],
                                  commentType: CommentType.home,
                                ),
                              );
                            },
                          ),
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
              CommonInput(
                maxLine: 5,
                hintText: context.l10n.t_leave_comment,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.routeCommentListScreen,
                    arguments: CommentArgs(
                      itemId: int.parse(widget.data?.feedId ?? ''),
                      title: 'Comments',
                      commentType: CommentType.home,
                      data: null,
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildViewCount(
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.viewIcons,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              value,
              style: context.bodyTextPrimaryStyle()!.copyWith(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(Widget icon, String value, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 14,
          ),
          Text(
            value,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(FeedType feedType) {
    switch (feedType) {
      case FeedType.advancedEvent:
        return Html(
          data: widget.data?.feedCustomHtml ?? '',
        );
      case FeedType.advancedSong:
        return Container(
          padding: const EdgeInsets.all(14),
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.mainColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data?.customDataCache?.title ?? '',
                style: context.buttonTextStyle()!.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.data?.customDataCache?.totalPlay ?? '0',
                          style: context.buttonTextStyle()!.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                        ),
                        TextSpan(
                          text: '  plays',
                          style: context.buttonTextStyle()!.copyWith(
                                fontSize: 14,
                                color: AppColors.subTitleColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.routeDetailSong,
                        arguments: {'song_id': widget.data?.customDataCache!.songId},
                      );
                    },
                    child: SvgPicture.asset(
                      AppAssets.songDetailIcon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 28,
                  )
                ],
              )
            ],
          ),
        );
      case FeedType.userStatus:
        if (widget.data!.statusBackground!.isEmpty) {
          return Text(
            widget.data?.feedStatus ?? '',
            style: context.buttonTextStyle()!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: widget.data?.statusBackground ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minHeight: 50),
                  child: const LoadingWidget(),
                )),
                errorWidget: (
                  BuildContext context,
                  _,
                  __,
                ) =>
                    const Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/cover.jpg',
                  ),
                ),
              ),
              Text(
                widget.data?.feedStatus ?? '',
                style: context.buttonTextStyle()!.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
              ),
            ],
          );
        }
      case FeedType.photo:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data?.feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            if (widget.data?.apiFeedImage != null)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                children: widget.data!.feedImageUrl!
                    .map(
                      (e) => CachedNetworkImage(
                        imageUrl: e,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
              )
            else
              const SizedBox(),
          ],
        );
      case FeedType.userCover:
        return CachedNetworkImage(
          imageUrl: widget.data?.feedImageUrl?[0] ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
              child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(minHeight: 50),
            child: const LoadingWidget(),
          )),
          errorWidget: (
            BuildContext context,
            _,
            __,
          ) =>
              const Image(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/cover.jpg',
            ),
          ),
        );
      case FeedType.userPhoto:
        return CachedNetworkImage(
          imageUrl: widget.data?.feedImageUrl?[0] ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
              child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(minHeight: 50),
            child: const LoadingWidget(),
          )),
          errorWidget: (
            BuildContext context,
            _,
            __,
          ) =>
              const Image(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/cover.jpg',
            ),
          ),
        );
      case FeedType.video:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data?.feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            Html(
              data: widget.data?.embedCode ?? '',
            )
          ],
        );
      case FeedType.none:
        return Container();
    }
  }
}
