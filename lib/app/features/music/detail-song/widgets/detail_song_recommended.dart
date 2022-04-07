import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../../../../injections.dart';

class DetailSongRecommended extends StatefulWidget {
  const DetailSongRecommended({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  State<DetailSongRecommended> createState() => _DetailSongRecommendedState();
}

class _DetailSongRecommendedState extends State<DetailSongRecommended> {
  DetailSongBloc songBloc = DetailSongBloc(locator.get());

  @override
  void initState() {
    super.initState();
    songBloc.getSongRecommended(widget.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState<List<Song>>>(
      initialData: const BlocState.loading(),
      stream: songBloc.getSongRecommendedStream,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        return state.when(
          success: (success) {
            final data = success as List<Song>;

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
                    context.l10n.t_recommended_song,
                    style: context.buttonTextStyle()!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: ListView.separated(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => SongItem(
                        song: data[index],
                        songs: data,
                        index: index,
                        fromDetail: true,
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
                songBloc.getSongRecommended(widget.id ?? 0);
              },
            );
          },
        );
      },
    );
  }
}
