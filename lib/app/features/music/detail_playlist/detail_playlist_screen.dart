import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_comment.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_description.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_navbar.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_photo.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_play_button.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_recommended.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_songs.dart';
import 'package:audio_cult/app/features/music/detail_playlist/widgets/detail_playlist_title.dart';
import 'package:audio_cult/app/features/music/library/update_playlist_params.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
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
  final _bloc = DetailPlayListBloc(locator.get());

  @override
  void initState() {
    super.initState();
    _bloc.getPlayListDetail(int.parse(widget.playListId ?? ''));
    _bloc.deletePlayListStream.listen((data) {
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
        bloc: _bloc,
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
          body: RefreshIndicator(
            color: AppColors.primaryButtonColor,
            backgroundColor: AppColors.secondaryButtonColor,
            onRefresh: () async {
              _bloc.getPlayListDetail(int.parse(widget.playListId ?? ''));
            },
            child: StreamBuilder<BlocState<PlaylistResponse>>(
              initialData: const BlocState.loading(),
              stream: _bloc.getPlayListDetailStream,
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
                                  _bloc.deletePlayList(int.parse(widget.playListId ?? ''));
                                },
                                onEdit: () async {
                                  final result =
                                      await Navigator.pushNamed(context, AppRoute.routeCreatePlayList, arguments: {
                                    'update_playlist_params': UpdatePlaylistParams(
                                      title: detail.title,
                                      description: detail.description,
                                      imagePath: detail.imagePath,
                                      id: int.parse(widget.playListId ?? ''),
                                    )
                                  });

                                  if (result != null) {
                                    _bloc.getPlayListDetail(int.parse(widget.playListId ?? ''));
                                  }
                                },
                              ),
                              //Title
                              DetailPlayListTitle(
                                time: detail.timeStamp,
                                userName: detail.fullName,
                                title: detail.title,
                                userId: detail.userId,
                              ),
                              // Play Button
                              DetailPlayListPlayButton(
                                detailPlayListBloc: _bloc,
                              ),
                            ],
                          ),
                        ),
                        //Detail playlist description
                        DetailPlaylistDescription(
                          description: detail.description,
                        ),
                        //Detail songs by album id
                        DetailPlayListSongs(
                          userId: detail.userId,
                          playListId: widget.playListId ?? '',
                          totalComments: detail.totalComments,
                          iconPath: detail.lastIcon?.imagePath,
                          totalLike: detail.totalLikes,
                          totalViews: detail.totalView,
                          detailPlayListBloc: _bloc,
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
                          bloc: _bloc,
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
