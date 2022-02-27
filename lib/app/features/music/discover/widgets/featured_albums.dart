import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/album_item.dart';
import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:flutter/material.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';

class FeaturedAlbums extends StatelessWidget {
  const FeaturedAlbums({
    Key? key,
    this.onRetry,
  }) : super(key: key);

  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Featured Albums',
          ),
          const SizedBox(
            height: 16,
          ),
          StreamBuilder<BlocState<List<Album>>>(
            initialData: const BlocState.loading(),
            stream: locator.get<DiscoverBloc>().getAlbumStream,
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
                        return AlbumItem(
                          album: albums[index],
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
