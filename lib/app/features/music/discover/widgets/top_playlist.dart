import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/features/music/discover/widgets/album_item.dart';
import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../discover_bloc.dart';

class TopPlaylist extends StatelessWidget {
  const TopPlaylist({
    Key? key,
    this.onShowAll,
    this.onRetry,
  }) : super(key: key);

  final Function()? onShowAll;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: context.localize.t_top_of_playlist,
            onShowAll: onShowAll,
          ),
          const SizedBox(
            height: 16,
          ),
          StreamBuilder<BlocState<List<PlaylistResponse>>>(
            initialData: const BlocState.loading(),
            stream: getIt.get<DiscoverBloc>().getPlaylistStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (success) {
                  final playlist = success as List<PlaylistResponse>;

                  return SizedBox(
                    height: 278,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return WButtonInkwell(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.routeDetailPlayList,
                              arguments: {
                                'playlist_id': playlist[index].playlistId,
                              },
                            );
                          },
                          child: AlbumItem(
                            playlist: playlist[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemCount: playlist.length,
                    ),
                  );
                },
                loading: () {
                  return const Center(child: LoadingWidget());
                },
                error: (error) {
                  return ErrorSectionWidget(
                    errorMessage: error,
                    onRetryTap: onRetry,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
