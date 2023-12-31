import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/requests/remove_song_request.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/top_playlist/top_playlist_bloc.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../../../../data_source/repositories/app_repository.dart';
import '../../../../injections.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';
import '../../discover/widgets/song_item.dart';

class TopPlaylistItem extends StatefulWidget {
  const TopPlaylistItem({
    Key? key,
    this.onShowAll,
    this.playlist,
  }) : super(key: key);

  final Function()? onShowAll;
  final PlaylistResponse? playlist;

  @override
  State<TopPlaylistItem> createState() => _TopPlaylistItemState();
}

class _TopPlaylistItemState extends State<TopPlaylistItem> {
  final TopPlaylistBloc _playlistBloc = TopPlaylistBloc(locator.get<AppRepository>());
  final _pageController = PageController();
  var _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _playlistBloc.getSongByPlaylistId(int.parse(widget.playlist!.playlistId!), 1, 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          WButtonInkwell(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoute.routeDetailPlayList,
                arguments: {
                  'playlist_id': widget.playlist?.playlistId,
                },
              );
            },
            child: CommonImageNetWork(
              width: double.infinity,
              height: 150,
              imagePath: widget.playlist?.imagePath ?? '',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WButtonInkwell(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.routeDetailPlayList,
                        arguments: {
                          'playlist_id': widget.playlist?.playlistId,
                        },
                      );
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.playlist?.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      WButtonInkwell(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.routeProfile,
                            arguments: ProfileScreen.createArguments(id: widget.playlist?.userId ?? ''),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            widget.playlist?.userName ?? '',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: AppColors.subTitleColor,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 5,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          widget.playlist!.countSongs.toString(),
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.subTitleColor,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              WButtonInkwell(
                onPressed: widget.onShowAll,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'See all songs',
                    style: context.bodyTextPrimaryStyle()!.copyWith(
                          fontSize: 16,
                          color: AppColors.lightBlue,
                        ),
                  ),
                ),
              ),
            ],
          ),
          _buildPages(),
        ],
      ),
    );
  }

  Widget _buildPages() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: (index) {
          _playlistBloc.getSongByPlaylistId(int.parse(widget.playlist!.playlistId!), index + 1, 3);
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        itemCount: 2,
        itemBuilder: (context, index) {
          return StreamBuilder<BlocState<List<Song>>>(
            initialData: const BlocState.loading(),
            stream: _playlistBloc.getSongByIdStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (data) {
                  final songs = data as List<Song>;

                  return Row(
                    children: [
                      if (songs.isNotEmpty)
                        Expanded(
                          child: Center(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: songs.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 20),
                              itemBuilder: (context, index) {
                                return SongItem(
                                  hasMenu: songs[index].userId == locator<PrefProvider>().currentUserId,
                                  song: songs[index],
                                  songs: songs,
                                  index: index,
                                  currency: _playlistBloc.currency,
                                );
                              },
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Center(
                            child: Text(
                              context.localize.t_no_data,
                            ),
                          ),
                        ),
                      Center(
                        child: WButtonInkwell(
                          onPressed: () {
                            _pageController.animateToPage(
                              ++index > 1 ? 0 : index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            _playlistBloc.getSongByPlaylistId(
                              int.parse(widget.playlist!.playlistId!),
                              ++index > 1 ? 0 : index,
                              3,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
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
                    onRetryTap: () {
                      _playlistBloc.getSongByPlaylistId(int.parse(widget.playlist!.playlistId!), _currentIndex + 1, 3);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
