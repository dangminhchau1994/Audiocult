import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_comment.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_navbar.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_photo.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_play_button.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_recommended.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_songs.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_title.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';

class DetailPlayListScreen extends StatefulWidget {
  const DetailPlayListScreen({
    Key? key,
    this.playListId,
  }) : super(key: key);

  final String? playListId;

  @override
  State<DetailPlayListScreen> createState() => _DetailPlayListScreenState();
}

class _DetailPlayListScreenState extends State<DetailPlayListScreen> with DisposableStateMixin {
  @override
  void initState() {
    super.initState();
    getIt<DetailPlayListBloc>().getPlayListDetail(int.parse(widget.playListId ?? ''));
    getIt.get<DetailPlayListBloc>().deletePlayListStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocHandle(
        bloc: getIt<DetailPlayListBloc>(),
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
          body: RefreshIndicator(
            color: AppColors.primaryButtonColor,
            backgroundColor: AppColors.secondaryButtonColor,
            onRefresh: () async {
              getIt<DetailPlayListBloc>().getPlayListDetail(int.parse(widget.playListId ?? ''));
            },
            child: StreamBuilder<BlocState<PlaylistResponse>>(
              initialData: const BlocState.loading(),
              stream: getIt<DetailPlayListBloc>().getPlayListDetailStream,
              builder: (context, snapshot) {
                final state = snapshot.data!;

                return state.when(
                  success: (data) {
                    final detail = data as PlaylistResponse;

                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Stack(
                            children: [
                              //Photo
                              DetailPlayListPhoto(
                                imagePath: detail.imagePath,
                              ),
                              //Navbar
                              DetailPlayListNavBar(
                                userId: detail.userId,
                                onDelete: () {
                                  getIt.get<DetailPlayListBloc>().deletePlayList(int.parse(widget.playListId ?? ''));
                                },
                              ),
                              //Title
                              DetailPlayListTitle(
                                time: detail.timeStamp,
                                userName: detail.fullName,
                                title: detail.title,
                              ),
                              // Play Button
                              DetailPlayListPlayButton(
                                detailPlayListBloc: getIt<DetailPlayListBloc>(),
                              ),
                            ],
                          ),
                        ),
                        //Detail songs by album id
                        DetailPlayListSongs(
                          playListId: widget.playListId ?? '',
                          totalComments: detail.totalComments,
                          iconPath: detail.lastIcon?.imagePath,
                          totalLike: detail.totalLikes,
                          totalViews: detail.totalView,
                          detailPlayListBloc: getIt<DetailPlayListBloc>(),
                          id: int.parse(widget.playListId ?? ''),
                          title: detail.title,
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
      ),
    );
  }
}
