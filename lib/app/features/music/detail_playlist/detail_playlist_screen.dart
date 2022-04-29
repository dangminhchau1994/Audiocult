import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/custom_sliver_playlist.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_comment.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_navbar.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_photo.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_play_button.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_recommended.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_songs.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_title.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:flutter/material.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../utils/constants/app_colors.dart';

class DetailPlayListScreen extends StatefulWidget {
  const DetailPlayListScreen({
    Key? key,
    this.playListId,
  }) : super(key: key);

  final String? playListId;

  @override
  State<DetailPlayListScreen> createState() => _DetailPlayListScreenState();
}

class _DetailPlayListScreenState extends State<DetailPlayListScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<DetailPlayListBloc>().getPlayListDetail(int.parse(widget.playListId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: RefreshIndicator(
          color: AppColors.primaryButtonColor,
          backgroundColor: AppColors.secondaryButtonColor,
          onRefresh: () async {
            getIt.get<DetailPlayListBloc>().getPlayListDetail(int.parse(widget.playListId ?? ''));
          },
          child: StreamBuilder<BlocState<PlaylistResponse>>(
            initialData: const BlocState.loading(),
            stream: getIt.get<DetailPlayListBloc>().getPlayListDetailStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (data) {
                  final detail = data as PlaylistResponse;

                  return CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: CustomSliverPlayList(
                          detail: detail,
                          expandedHeight: 300,
                        ),
                      ),
                      //Detail songs by album id
                      DetailPlayListSongs(
                        playListId: widget.playListId ?? '',
                        totalComments: detail.totalComments,
                        totalLike: detail.totalLikes,
                        totalViews: detail.totalView,
                      ),
                      //Comment
                      DetailPlayListComment(
                        id: int.parse(widget.playListId ?? ''),
                        title: detail.title,
                      ),
                      //Recommended Songs
                      DetailPlayListRecommended(
                        id: int.parse(widget.playListId ?? ''),
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
        ),
      ),
    );
  }
}
