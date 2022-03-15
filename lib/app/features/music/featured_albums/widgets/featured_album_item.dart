import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../data_source/repositories/app_repository.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/datetime/date_time_utils.dart';
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
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _featuredAlbumBloc.getSongByAlbumId(int.parse(widget.album!.albumId!), 1, 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 140,
            imageUrl: widget.album?.imagePath ?? '',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryButtonColor,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      widget.album?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.album?.fullName ?? '',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: AppColors.subTitleColor,
                              fontSize: 16,
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
                child: Text(
                  'See all songs',
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        fontSize: 16,
                        color: AppColors.lightBlue,
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
      height: 196,
      child: PageView.builder(
        onPageChanged: (index) {
          _featuredAlbumBloc.getSongByAlbumId(int.parse(widget.album!.albumId!), index + 1, 3);
          setState(() {
            _currentIndex = index;
          });
        },
        controller: PageController(viewportFraction: 0.96),
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
                  return songs.isNotEmpty
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: songs.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            return SongItem(
                              song: songs[index],
                              hasMenu: true,
                            );
                          },
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
