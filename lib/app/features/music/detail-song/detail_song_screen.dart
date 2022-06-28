import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/detail-song/detail_song_bloc.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_comment.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_description.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_navbar.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_photo.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_play_button.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_recommended.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_title.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../di/bloc_locator.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../utils/constants/app_colors.dart';

class DetailSongScreen extends StatefulWidget {
  const DetailSongScreen({
    Key? key,
    this.songId,
    this.fromNotificatiton,
  }) : super(key: key);

  final String? songId;
  final bool? fromNotificatiton;

  @override
  State<DetailSongScreen> createState() => _DetailSongScreenState();
}

class _DetailSongScreenState extends State<DetailSongScreen> {
  late final ScrollController _scrollController =
      ScrollController(initialScrollOffset: widget.fromNotificatiton ?? false ? 1800 : 0);

  @override
  void initState() {
    super.initState();
    getIt.get<DetailSongBloc>().getSongDetail(int.parse(widget.songId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt.get<DetailSongBloc>(),
      child: GestureDetector(
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
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Stack(
                            children: [
                              //Photo
                              DetailPhotoSong(
                                imagePath: detail.imagePath,
                              ),
                              //Navbar
                              DetailSongNavBar(
                                songId: detail.songId,
                              ),
                              //Title
                              DetailSongTitle(
                                time: detail.timeStamp,
                                artistName: detail.artistUser?.userName,
                                title: detail.title,
                              ),
                              // Play Button
                              DetailSongPlayButton(
                                song: detail,
                              ),
                            ],
                          ),
                        ),
                        _addToCartBuilder(detail),
                        //Description
                        DetailSongDescription(
                          data: detail,
                          id: int.parse(widget.songId ?? ''),
                          title: detail.title,
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
      ),
    );
  }

  Widget _addToCartBuilder(Song song) {
    return StreamBuilder<bool>(
      stream: getIt.get<DetailSongBloc>().addItemToCartStream,
      builder: (_, snapshot) {
        final allowToBuy = double.parse(song.cost ?? '0') > 0;
        if (!allowToBuy) return SliverToBoxAdapter(child: Container());
        final alreadyAdded = snapshot.data ?? getIt.get<MyCartBloc>().isSongAlreadyAdded(song);
        return addCartButton(song, alreadyAdded);
      },
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Widget addCartButton(Song song, bool alreadyAdded) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: () => alreadyAdded ? null : getIt.get<DetailSongBloc>().addSongToCart(song),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: alreadyAdded ? Colors.blueGrey : AppColors.primaryButtonColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(alreadyAdded ? AppAssets.icAllEvents : AppAssets.cartIcon),
                  const SizedBox(width: 8),
                  Text(context.l10n.t_add_to_cart, style: context.body1TextStyle()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
