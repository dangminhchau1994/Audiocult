import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../w_components/comment/comment_args.dart';
import '../../../../../w_components/comment/comment_list_screen.dart';
import '../../../../../w_components/dialogs/report_dialog.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../../w_components/menus/common_popup_menu.dart';
import '../../../../../w_components/reactions/common_reaction.dart';
import '../../../../base/bloc_state.dart';
import '../../../../data_source/local/pref_provider.dart';
import '../../../../data_source/models/requests/remove_song_request.dart';
import '../../../../data_source/models/responses/song/song_response.dart';
import '../../../../injections.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';
import '../../discover/widgets/song_item.dart';

class DetailPlayListSongs extends StatefulWidget {
  const DetailPlayListSongs({
    Key? key,
    this.songs,
    this.playListId,
    this.totalComments,
    this.detailPlayListBloc,
    this.totalLike,
    this.totalViews,
    this.iconPath,
    this.id,
    this.title,
    this.userId,
  }) : super(key: key);

  final List<Song>? songs;
  final DetailPlayListBloc? detailPlayListBloc;
  final String? playListId;
  final String? totalLike;
  final String? totalComments;
  final String? iconPath;
  final String? totalViews;
  final int? id;
  final String? userId;
  final String? title;

  @override
  State<DetailPlayListSongs> createState() => _DetailPlayListSongsState();
}

class _DetailPlayListSongsState extends State<DetailPlayListSongs> {
  @override
  void initState() {
    super.initState();
    widget.detailPlayListBloc?.getSongByPlayListId(int.parse(widget.playListId ?? ''), 1, GlobalConstants.loadMoreItem);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            StreamBuilder<BlocState<List<Song>>>(
              initialData: const BlocState.loading(),
              stream: widget.detailPlayListBloc?.getSongByIdStream,
              builder: (context, snapshot) {
                final state = snapshot.data!;

                return state.when(
                  success: (data) {
                    final songs = data as List<Song>;
                    return songs.isNotEmpty
                        ? StreamBuilder<List<Song>>(
                            stream: widget.detailPlayListBloc?.removeItemSongStream,
                            initialData: songs,
                            builder: (context, snapshot) {
                              final data = snapshot.data;

                              return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data?.length ?? 0,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => const SizedBox(height: 20),
                                itemBuilder: (context, index) {
                                  return SongItem(
                                    song: data?[index],
                                    songs: data,
                                    index: index,
                                    hasMenu: widget.userId == locator<PrefProvider>().currentUserId,
                                    fromDetail: true,
                                    currency: widget.detailPlayListBloc?.currency,
                                    removeFromPlaylist: () {
                                      widget.detailPlayListBloc?.removeSongFromPlaylist(
                                        RemoveSongRequest(
                                          songId: data?[index].songId,
                                          playlistId: int.parse(widget.playListId ?? '')
                                        ),
                                      );
                                      widget.detailPlayListBloc?.removeSongItem(songs, index);
                                    },
                                  );
                                },
                              );
                            },
                          )
                        : const SizedBox();
                  },
                  loading: () {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  },
                  error: (error) {
                    return ErrorSectionWidget(
                      errorMessage: error,
                      onRetryTap: () {
                        widget.detailPlayListBloc?.getSongByPlayListId(
                          int.parse(widget.playListId ?? ''),
                          1,
                          GlobalConstants.loadMoreItem,
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            //heart, comment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CommonReactions(
                      reactionType: ReactionType.playlist,
                      itemId: widget.playListId,
                      totalLike: widget.totalLike,
                      iconPath: widget.iconPath,
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
                            itemId: widget.id ?? 0,
                            title: widget.title ?? '',
                            commentType: CommentType.playlist,
                            data: null,
                          ),
                        );
                      },
                      child: _buildIcon(
                        SvgPicture.asset(AppAssets.commentIcon),
                        widget.totalComments ?? '0',
                        context,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    WButtonInkwell(
                      onPressed: () {},
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryButtonColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: CommonPopupMenu(
                            icon: SvgPicture.asset(
                              AppAssets.verticalIcon,
                              width: 24,
                              height: 24,
                            ),
                            items: GlobalConstants.menuDetail(context),
                            onSelected: (selected) {
                              switch (selected) {
                                case 0:
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      insetPadding: EdgeInsets.zero,
                                      contentPadding: EdgeInsets.zero,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                      ),
                                      content: Builder(
                                        builder: (context) => ReportDialog(
                                          type: ReportType.playlist,
                                          itemId: int.parse(widget.playListId ?? ''),
                                        ),
                                      ),
                                    ),
                                  );
                                  break;
                                case 1:
                                  break;
                                case 2:
                                  break;
                                default:
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                _buildPlayCount(widget.totalViews ?? '', context)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: AppColors.secondaryButtonColor,
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Widget icon, String value, BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryButtonColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
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
      ),
    );
  }

  Widget _buildPlayCount(
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.playCountIcon,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
