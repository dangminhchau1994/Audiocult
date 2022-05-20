import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../../../../injections.dart';
import '../../../../utils/route/app_route.dart';
import '../../search/search_item.dart';

class DetailPlayListRecommended extends StatefulWidget {
  const DetailPlayListRecommended({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  State<DetailPlayListRecommended> createState() => _DetailPlayListRecommendedState();
}

class _DetailPlayListRecommendedState extends State<DetailPlayListRecommended> {
  DetailPlayListBloc playListBloc = DetailPlayListBloc(locator.get());

  @override
  void initState() {
    super.initState();
    playListBloc.getPlayListRecommended(widget.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder<BlocState<List<PlaylistResponse>>>(
        initialData: const BlocState.loading(),
        stream: playListBloc.getPlayListRecommendedStream,
        builder: (context, snapshot) {
          final state = snapshot.data!;

          return state.when(
            success: (success) {
              final data = success as List<PlaylistResponse>;

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
                      context.l10n.t_recommended_playlist,
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
                              AppRoute.routeDetailPlayList,
                              arguments: {
                                'playlist_id': data[index].playlistId,
                              },
                            );
                          },
                          child: SearchItem(
                            playlist: data[index],
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
                  playListBloc.getPlayListRecommended(widget.id ?? 0);
                },
              );
            },
          );
        },
      ),
    );
  }
}
