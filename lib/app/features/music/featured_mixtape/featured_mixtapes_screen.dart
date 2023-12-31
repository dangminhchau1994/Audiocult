import 'package:audio_cult/app/features/music/featured_mixtape/featured_mixtapes_bloc.dart';
import 'package:audio_cult/app/features/player_widgets/player_screen.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/appbar/common_appbar.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/cache_filter.dart';
import '../../../data_source/models/requests/top_song_request.dart';
import '../../../data_source/models/responses/genre.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/route/app_route.dart';
import '../discover/widgets/song_item.dart';
import '../filter/enum_filter_music.dart';
import '../search/search_args.dart';

class FeaturedMixTapesScreen extends StatefulWidget {
  const FeaturedMixTapesScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final SearchArgs arguments;

  @override
  State<FeaturedMixTapesScreen> createState() => _FeaturedMixTapesScreenState();
}

class _FeaturedMixTapesScreenState extends State<FeaturedMixTapesScreen> with AutomaticKeepAliveClientMixin {
  final PagingController<int, Song> _pagingController = PagingController(firstPageKey: 1);
  late FeaturedMixtapesBloc _featuredMixtapesBloc;

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _featuredMixtapesBloc = getIt.get<FeaturedMixtapesBloc>();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _featuredMixtapesBloc.requestData(
      params: TopSongRequest(
        sort: 'most-viewed',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        view: 'featured',
        type: 'mixtape-song',
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _featuredMixtapesBloc.loadData(
        TopSongRequest(
          sort: 'most-viewed',
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          view: 'featured',
          type: 'mixtape-song',
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
        (r) => _featuredMixtapesBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.localize.t_featured_mixtapes,
        actions: [
          WButtonInkwell(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, AppRoute.routeMusicFilter,
                  arguments: TypeFilterMusic.featuresMixtapes);
              if (result != null) {
                final temp = result as CacheFilter;
                final sort = temp.mostLiked
                    ?.firstWhere((element) => element.isSelected, orElse: () => SelectMenuModel(title: 'Latest'))
                    .title;
                final genresId = temp.genres
                    ?.firstWhere((element) => element.isSelected == true, orElse: () => Genre(genreId: ''))
                    .genreId;
                final when = temp.allTime
                    ?.firstWhere((element) => element.isSelected == true, orElse: () => SelectMenuModel(title: ''))
                    .title;
                _pagingController.refresh();
                _pagingController.refresh();
                _featuredMixtapesBloc.requestData(
                  params: TopSongRequest(
                    sort: sort == 'Latest' ? 'Latest' : sort!.toLowerCase().replaceAll(' ', '_'),
                    page: 1,
                    genresId: genresId,
                    when: when!.toLowerCase().replaceAll(' ', '_'),
                    limit: GlobalConstants.loadMoreItem,
                    view: 'featured',
                    type: 'mixtape-song',
                  ),
                );
              }
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
          vertical: kVerticalSpacing - 10,
          horizontal: kHorizontalSpacing - 10,
        ),
        child: RefreshIndicator(
          color: AppColors.primaryButtonColor,
          backgroundColor: AppColors.secondaryButtonColor,
          onRefresh: () async {
            _pagingController.refresh();
            _featuredMixtapesBloc.requestData(
              params: TopSongRequest(
                sort: 'most-viewed',
                page: 1,
                limit: GlobalConstants.loadMoreItem,
                view: 'featured',
                type: 'mixtape-song',
              ),
            );
          },
          child: LoadingBuilder<FeaturedMixtapesBloc, List<Song>>(
            builder: (data, _) {
              //only first page
              final isLastPage = data.length <= GlobalConstants.loadMoreItem - 1;
              if (isLastPage) {
                _pagingController.appendLastPage(data);
              } else {
                _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
              }
              return RawScrollbar(
                child: PagedListView<int, Song>.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  pagingController: _pagingController,
                  separatorBuilder: (context, index) => const Divider(height: 24),
                  builderDelegate: PagedChildBuilderDelegate<Song>(
                    firstPageProgressIndicatorBuilder: (context) => Container(),
                    newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return SongItem(
                        song: item,
                        songs: _pagingController.itemList,
                        index: index,
                        currency: _featuredMixtapesBloc.currency,
                      );
                    },
                  ),
                ),
              );
            },
            reloadAction: (_) {
              _featuredMixtapesBloc.requestData(
                params: TopSongRequest(
                  sort: 'most-viewed',
                  page: 1,
                  limit: GlobalConstants.loadMoreItem,
                  view: 'featured',
                  type: 'mixtape-song',
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
