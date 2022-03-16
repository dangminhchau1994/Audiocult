import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../injections.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../discover/widgets/song_item.dart';
import '../detail_album_bloc.dart';

class DetailAlbumSongs extends StatefulWidget {
  const DetailAlbumSongs({
    Key? key,
    this.songs,
    this.albumId,
  }) : super(key: key);

  final List<Song>? songs;
  final String? albumId;

  @override
  State<DetailAlbumSongs> createState() => _DetailAlbumSongsState();
}

class _DetailAlbumSongsState extends State<DetailAlbumSongs> {
  DetailAlbumBloc albumBloc = DetailAlbumBloc(locator.get());

  @override
  void initState() {
    super.initState();
    albumBloc.getSongByAlbumId(int.parse(widget.albumId ?? ''), 1, 3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<BlocState<List<Song>>>(
          initialData: const BlocState.loading(),
          stream: albumBloc.getSongByIdStream,
          builder: (context, snapshot) {
            final state = snapshot.data!;

            return state.when(
              success: (data) {
                final songs = data as List<Song>;
                return songs.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 16,
                          right: 16,
                        ),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: songs.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            return SongItem(
                              song: songs[index],
                              hasMenu: true,
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          context.l10n.t_no_data,
                          style: AppTextStyles.normal,
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
                    albumBloc.getSongByAlbumId(int.parse(widget.albumId ?? '0'), 1, 3);
                  },
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          color: AppColors.secondaryButtonColor,
          height: 1,
        )
      ],
    );
  }
}