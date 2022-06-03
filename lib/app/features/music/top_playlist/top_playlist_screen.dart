import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/features/music/top_playlist/top_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/top_playlist/widgets/top_playlist_item.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../di/bloc_locator.dart';
import '../../../../w_components/appbar/common_appbar.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/album_playlist_request.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimens.dart';
import '../../../utils/route/app_route.dart';
import '../search/search_args.dart';

class TopPlaylistScreen extends StatefulWidget {
  const TopPlaylistScreen({Key? key, required this.arguments}) : super(key: key);

  final SearchArgs arguments;

  @override
  State<TopPlaylistScreen> createState() => _TopPlaylistScreenState();
}

class _TopPlaylistScreenState extends State<TopPlaylistScreen> {
  final PagingController<int, PlaylistResponse> _pagingController = PagingController(firstPageKey: 1);
  late TopPlaylistBloc _topPlaylistBloc;

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
    _topPlaylistBloc = getIt.get<TopPlaylistBloc>();
    _topPlaylistBloc.requestData(
      params: AlbumPlaylistRequest(
        query: '',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        sort: 'most-liked',
        getAll: 1,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _topPlaylistBloc.loadData(
        AlbumPlaylistRequest(
          query: '',
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          sort: 'most-liked',
          getAll: 1,
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
        (r) => _topPlaylistBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_top_playlist,
        actions: [
          WButtonInkwell(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.routeMusicFilter);
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
            _topPlaylistBloc.requestData(
              params: AlbumPlaylistRequest(
                query: '',
                page: 1,
                limit: GlobalConstants.loadMoreItem,
                sort: 'most-liked',
                getAll: 1,
              ),
            );
          },
          child: LoadingBuilder<TopPlaylistBloc, List<PlaylistResponse>>(
            builder: (data, _) {
              //only first page
              final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
              if (isLastPage) {
                _pagingController.appendLastPage(data);
              } else {
                _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
              }
              return Scrollbar(
                child: PagedListView<int, PlaylistResponse>.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalSpacing,
                    vertical: kVerticalSpacing,
                  ),
                  pagingController: _pagingController,
                  separatorBuilder: (context, index) => Divider(
                    height: 0.1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  builderDelegate: PagedChildBuilderDelegate<PlaylistResponse>(
                    firstPageProgressIndicatorBuilder: (context) => Container(),
                    newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return TopPlaylistItem(
                        playlist: item,
                      );
                    },
                  ),
                ),
              );
            },
            reloadAction: (_) {
              _pagingController.refresh();
              _topPlaylistBloc.requestData(
                params: AlbumPlaylistRequest(
                  query: '',
                  page: 1,
                  limit: GlobalConstants.loadMoreItem,
                  sort: 'most-liked',
                  getAll: 1,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
