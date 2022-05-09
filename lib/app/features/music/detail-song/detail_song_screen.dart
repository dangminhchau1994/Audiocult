import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song_detail/song_detail_response.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_bloc.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/custom_sliver_song.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_comment.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_description.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_recommended.dart';
import 'package:flutter/material.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../utils/constants/app_colors.dart';

class DetailSongScreen extends StatefulWidget {
  const DetailSongScreen({
    Key? key,
    this.songId,
  }) : super(key: key);

  final String? songId;

  @override
  State<DetailSongScreen> createState() => _DetailSongScreenState();
}

class _DetailSongScreenState extends State<DetailSongScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<DetailSongBloc>().getSongDetail(int.parse(widget.songId ?? ''));
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
            getIt.get<DetailSongBloc>().getSongDetail(int.parse(widget.songId ?? ''));
          },
          child: StreamBuilder<BlocState<Song>>(
            initialData: const BlocState.loading(),
            stream: getIt.get<DetailSongBloc>().getSongDetailStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (data) {
                  final detail = data as Song;

                  return CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: CustomSliverSong(
                          detail: detail,
                          expandedHeight: 300,
                        ),
                      ),
                      //Description
                      DetailSongDescription(
                        data: detail,
                      ),
                      //Comment
                      DetailSongComment(
                        id: int.parse(widget.songId ?? ''),
                        title: detail.title,
                      ),
                      //Recommended Songs
                      DetailSongRecommended(
                        id: int.parse(widget.songId ?? ''),
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
