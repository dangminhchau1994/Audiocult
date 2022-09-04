import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../injections.dart';
import '../../../../utils/route/app_route.dart';
import '../../search/search_item.dart';

class DetailAlbumRecommended extends StatefulWidget {
  const DetailAlbumRecommended({
    Key? key,
    this.id,
  }) : super(key: key);

  final String? id;

  @override
  State<DetailAlbumRecommended> createState() => _DetailAlbumRecommendedState();
}

class _DetailAlbumRecommendedState extends State<DetailAlbumRecommended> {
  DetailAlbumBloc albumBloc = DetailAlbumBloc(locator.get());

  @override
  void initState() {
    super.initState();
    albumBloc.getAlbumRecommended(int.parse(widget.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder<BlocState<List<Album>>>(
        initialData: const BlocState.loading(),
        stream: albumBloc.getAlumRecommendedStream,
        builder: (context, snapshot) {
          final state = snapshot.data!;

          return state.when(
            success: (success) {
              final data = success as List<Album>;

              return Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localize.t_recommended_albums,
                      style: context.buttonTextStyle()!.copyWith(
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 30,
                      ),
                      child: ListView.separated(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => WButtonInkwell(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.routeDetailAlbum,
                              arguments: {
                                'album_id': data[index].albumId,
                              },
                            );
                          },
                          child: SearchItem(
                            album: data[index],
                          ),
                        ),
                        separatorBuilder: (context, index) => const Divider(height: 40),
                      ),
                    ),
                  ],
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
                  albumBloc.getAlbumRecommended(int.parse(widget.id ?? ''));
                },
              );
            },
          );
        },
      ),
    );
  }
}
