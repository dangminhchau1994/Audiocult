import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_bloc.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_comment.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_description.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_navbar.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_photo.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_play_button.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_recommended.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_songs.dart';
import 'package:audio_cult/app/features/music/detail_album/widgets/detail_album_title.dart';
import 'package:flutter/material.dart';

import '../../../../di/bloc_locator.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../utils/constants/app_colors.dart';

class DetailAlbumScreen extends StatefulWidget {
  const DetailAlbumScreen({
    Key? key,
    this.albumId,
  }) : super(key: key);

  final String? albumId;

  @override
  State<DetailAlbumScreen> createState() => _DetailAlbumScreenState();
}

class _DetailAlbumScreenState extends State<DetailAlbumScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<DetailAlbumBloc>().getAlbumDetail(int.parse(widget.albumId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          getIt.get<DetailAlbumBloc>().getAlbumDetail(int.parse(widget.albumId ?? ''));
        },
        child: StreamBuilder<BlocState<Album>>(
          initialData: const BlocState.loading(),
          stream: getIt.get<DetailAlbumBloc>().getAlbumDetailStream,
          builder: (context, snapshot) {
            final state = snapshot.data!;

            return state.when(
              success: (data) {
                final detail = data as Album;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          //Photo
                          DetailAlbumPhoto(
                            imagePath: detail.imagePath,
                          ),
                          //Navbar
                          const DetailAlbumNavBar(),
                          //Title
                          DetailAlbumTitle(
                            time: detail.timeStamp,
                            artistName: detail.artistUser,
                            title: detail.name,
                          ),
                          // Play Button
                          const DetailAlbumPlayButton(),
                        ],
                      ),
                      //Detail songs by album id
                      DetailAlbumSongs(
                        albumId: widget.albumId ?? '',
                      ),
                      //Description
                      DetailAlbumDescription(
                        data: detail,
                      ),
                      //Comment
                      DetailAlbumComment(
                        id: int.parse(widget.albumId ?? ''),
                      ),
                      //Recommended Songs
                      const DetailAlbumRecommended(),
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
                  onRetryTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}