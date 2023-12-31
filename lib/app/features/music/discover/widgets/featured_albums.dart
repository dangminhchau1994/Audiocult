import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/album_item.dart';
import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../utils/route/app_route.dart';

class FeaturedAlbums extends StatelessWidget {
  const FeaturedAlbums({
    Key? key,
    this.onRetry,
    this.onShowAll,
  }) : super(key: key);

  final Function()? onRetry;
  final Function()? onShowAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: context.localize.t_featured_albums,
            onShowAll: onShowAll,
          ),
          const SizedBox(
            height: 16,
          ),
          StreamBuilder<BlocState<List<Album>>>(
            initialData: const BlocState.loading(),
            stream: getIt.get<DiscoverBloc>().getAlbumStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (success) {
                  final albums = success as List<Album>;

                  return SizedBox(
                    height: 278,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return WButtonInkwell(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.routeDetailAlbum,
                              arguments: {
                                'album_id': albums[index].albumId,
                              },
                            );
                          },
                          child: AlbumItem(
                            album: albums[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemCount: albums.length,
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
