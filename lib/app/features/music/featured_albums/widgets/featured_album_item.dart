import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_bloc.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../data_source/repositories/app_repository.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/datetime/date_time_utils.dart';
import '../../../../utils/route/app_route.dart';
import '../../discover/widgets/song_item.dart';

class FeaturedAlbumItem extends StatefulWidget {
  const FeaturedAlbumItem({
    Key? key,
    this.onShowAll,
    this.album,
  }) : super(key: key);

  final Function()? onShowAll;
  final Album? album;

  @override
  State<FeaturedAlbumItem> createState() => _FeaturedAlbumItemState();
}

class _FeaturedAlbumItemState extends State<FeaturedAlbumItem> {
  final FeaturedAlbumBloc _featuredAlbumBloc = FeaturedAlbumBloc(locator.get<AppRepository>());
  final _pageController = PageController();
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _featuredAlbumBloc.getSongByAlbumId(int.parse(widget.album!.albumId!), 1, 3);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          WButtonInkwell(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoute.routeDetailAlbum,
                arguments: {
                  'album_id': widget.album?.albumId,
                },
              );
            },
            child: CommonImageNetWork(
              width: double.infinity,
              height: 140,
              imagePath: widget.album?.imagePath ?? '',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WButtonInkwell(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.routeDetailAlbum,
                        arguments: {
                          'album_id': widget.album?.albumId,
                        },
                      );
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.album?.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      WButtonInkwell(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.routeProfile,
                            arguments: ProfileScreen.createArguments(id: widget.album?.userId ?? ''),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            widget.album?.userName ?? '',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: AppColors.subTitleColor,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 5,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateTimeUtils.formatyMMMMd(int.parse(widget.album?.timeStamp ?? '')),
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: AppColors.subTitleColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              WButtonInkwell(
                onPressed: widget.onShowAll,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'See all songs',
                    style: context.bodyTextPrimaryStyle()!.copyWith(
                          fontSize: 16,
                          color: AppColors.lightBlue,
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          _buildPages(),
        ],
      ),
    );
  }

  Widget _buildPages() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: (index) {
          _featuredAlbumBloc.getSongByAlbumId(int.parse(widget.album!.albumId!), index + 1, 3);
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return StreamBuilder<BlocState<List<Song>>>(
            initialData: const BlocState.loading(),
            stream: _featuredAlbumBloc.getSongByIdStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (data) {
                  final songs = data as List<Song>;
                  return Row(
                    children: [
                      if (songs.isNotEmpty)
                        Expanded(
                          child: Center(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: songs.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 20),
                              itemBuilder: (context, index) {
                                return SongItem(
                                  hasMenu: false,
                                  song: songs[index],
                                  songs: songs,
                                  index: index,
                                  currency: _featuredAlbumBloc.currency,
                                );
                              },
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Center(
                            child: Text(
                              context.localize.t_no_data,
                            ),
                          ),
                        ),
                      Center(
                        child: WButtonInkwell(
                          onPressed: () {
                            _pageController.animateToPage(
                              ++index > 1 ? 0 : index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            _featuredAlbumBloc.getSongByAlbumId(
                              int.parse(widget.album!.albumId!),
                              ++index > 1 ? 0 : index,
                              3,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
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
                    onRetryTap: () {
                      _featuredAlbumBloc.getSongByAlbumId(int.parse(widget.album!.albumId!), _currentIndex + 1, 3);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
