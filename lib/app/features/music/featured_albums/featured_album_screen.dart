import 'package:audio_cult/app/data_source/models/requests/album_playlist_request.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/features/music/featured_albums/featured_album_bloc.dart';
import 'package:audio_cult/app/features/music/featured_albums/widgets/featured_album_item.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../filter/enum_filter_music.dart';
import '../search/search_args.dart';

class FeaturedAlbumScreen extends StatefulWidget {
  const FeaturedAlbumScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final SearchArgs arguments;

  @override
  State<FeaturedAlbumScreen> createState() => _FeaturedAlbumScreenState();
}

class _FeaturedAlbumScreenState extends State<FeaturedAlbumScreen> {
  final PagingController<int, Album> _pagingController = PagingController(firstPageKey: 1);
  late FeaturedAlbumBloc _albumPlaylistBloc;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _albumPlaylistBloc.loadData(
        AlbumPlaylistRequest(
          query: '',
          view: 'featured',
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
        ),
      );
      newItems.fold(
        (l) {
          final isLastPage = l.length < GlobalConstants.loadMoreItem;
          if (isLastPage) {
            _pagingController.appendLastPage(l);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(l, nextPageKey);
          }
        },
        (r) => _albumPlaylistBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _albumPlaylistBloc = getIt.get<FeaturedAlbumBloc>();
    _albumPlaylistBloc.requestData(
      params: AlbumPlaylistRequest(
        query: '',
        view: 'featured',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_featured_album,
        actions: [
          WButtonInkwell(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.routeMusicFilter, arguments: TypeFilterMusic.featuresAlbum);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.inputFillColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AppAssets.filterIcon,
                fit: BoxFit.cover,
              ),
            ),
          ),
          WButtonInkwell(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoute.routeSearch,
                arguments: widget.arguments,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.inputFillColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AppAssets.searchIcon,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: kVerticalSpacing,
          horizontal: kHorizontalSpacing,
        ),
        child: RefreshIndicator(
          color: AppColors.primaryButtonColor,
          backgroundColor: AppColors.secondaryButtonColor,
          onRefresh: () async {
            _pagingController.refresh();
            _albumPlaylistBloc.requestData(
              params: AlbumPlaylistRequest(
                query: '',
                view: 'featured',
                page: 1,
                limit: GlobalConstants.loadMoreItem,
              ),
            );
          },
          child: LoadingBuilder<FeaturedAlbumBloc, List<Album>>(
            builder: (data, _) {
              //only first page
              final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
              if (isLastPage) {
                _pagingController.appendLastPage(data);
              } else {
                _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
              }
              return Scrollbar(
                child: PagedListView<int, Album>.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  pagingController: _pagingController,
                  separatorBuilder: (context, index) => Divider(
                    height: 0.1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  builderDelegate: PagedChildBuilderDelegate<Album>(
                    firstPageProgressIndicatorBuilder: (context) => Container(),
                    newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return FeaturedAlbumItem(
                        album: item,
                        onShowAll: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.routeDetailAlbum,
                            arguments: {
                              'album_id': item.albumId,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
            reloadAction: (_) {
              _pagingController.refresh();
              _albumPlaylistBloc.requestData(
                params: AlbumPlaylistRequest(
                  query: '',
                  view: 'featured',
                  page: 1,
                  limit: GlobalConstants.loadMoreItem,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
