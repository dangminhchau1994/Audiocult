import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../data_source/models/responses/song/song_response.dart';
import '../../../../injections.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../discover/widgets/song_item.dart';

class DetailPlayListSongs extends StatefulWidget {
  const DetailPlayListSongs({
    Key? key,
    this.songs,
    this.playListId,
    this.totalComments,
    this.totalLike,
    this.totalViews,
  }) : super(key: key);

  final List<Song>? songs;
  final String? playListId;
  final String? totalLike;
  final String? totalComments;
  final String? totalViews;

  @override
  State<DetailPlayListSongs> createState() => _DetailPlayListSongsState();
}

class _DetailPlayListSongsState extends State<DetailPlayListSongs> {
  DetailPlayListBloc playListBloc = DetailPlayListBloc(locator.get());

  @override
  void initState() {
    super.initState();
    playListBloc.getSongByPlayListId(int.parse(widget.playListId ?? ''), 1, GlobalConstants.loadMoreItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          StreamBuilder<BlocState<List<Song>>>(
            initialData: const BlocState.loading(),
            stream: playListBloc.getSongByIdStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (data) {
                  final songs = data as List<Song>;
                  return songs.isNotEmpty
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: songs.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            return SongItem(
                              song: songs[index],
                              songs: songs,
                              index: index,
                              fromDetail: true,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            context.l10n.t_no_data,
                            style: AppTextStyles.normal,
                          ),
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
                    onRetryTap: () {
                      playListBloc.getSongByPlayListId(
                          int.parse(widget.playListId ?? ''), 1, GlobalConstants.loadMoreItem);
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
                  _buildIcon(
                    SvgPicture.asset(AppAssets.heartIcon),
                    widget.totalLike ?? '0',
                    context,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildIcon(
                    SvgPicture.asset(AppAssets.commentIcon),
                    widget.totalComments ?? '0',
                    context,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.secondaryButtonColor,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: SvgPicture.asset(AppAssets.shareIcon),
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
    );
  }

  Widget _buildIcon(Widget icon, String value, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryButtonColor,
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
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
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
