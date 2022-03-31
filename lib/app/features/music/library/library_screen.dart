import 'package:audio_cult/app/features/music/library/library_bloc.dart';
import 'package:audio_cult/app/features/music/library/widgets/empty_playlist.dart';
import 'package:audio_cult/app/features/music/search/search_item.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/album_playlist_request.dart';
import '../../../data_source/models/responses/playlist/playlist_response.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with AutomaticKeepAliveClientMixin {
  final PagingController<int, PlaylistResponse> _pagingController = PagingController(firstPageKey: 1);
  late LibrayBloc _librayBloc;

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
    _librayBloc = getIt.get<LibrayBloc>();
    _librayBloc.requestData(
      params: AlbumPlaylistRequest(
        query: '',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        sort: 'most-liked',
        getAll: 0,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _librayBloc.loadData(
        AlbumPlaylistRequest(
          query: '',
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          sort: 'most-liked',
          getAll: 0,
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
        (r) => _librayBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing - 10,
          vertical: kVerticalSpacing - 10,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            RefreshIndicator(
              color: AppColors.primaryButtonColor,
              backgroundColor: AppColors.secondaryButtonColor,
              onRefresh: () async {
                _pagingController.refresh();
                _librayBloc.requestData(
                  params: AlbumPlaylistRequest(
                    query: '',
                    page: 1,
                    limit: GlobalConstants.loadMoreItem,
                    sort: 'most-liked',
                    getAll: 0,
                  ),
                );
              },
              child: LoadingBuilder<LibrayBloc, List<PlaylistResponse>>(
                builder: (data, _) {
                  if (data.isEmpty) {
                    return const EmptyPlayList();
                  }
                  //only first page
                  final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
                  if (isLastPage) {
                    _pagingController.appendLastPage(data);
                  } else {
                    _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
                  }
                  return SizedBox(
                    height: 500,
                    child: PagedListView<int, PlaylistResponse>.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      pagingController: _pagingController,
                      separatorBuilder: (context, index) => const Divider(
                        height: 20,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<PlaylistResponse>(
                        firstPageProgressIndicatorBuilder: (context) => Container(),
                        newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                        animateTransitions: true,
                        itemBuilder: (context, item, index) {
                          return WButtonInkwell(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeDetailPlayList,
                                arguments: {
                                  'playlist_id': data[index].playlistId,
                                },
                              );
                            },
                            child: SearchItem(
                              playlist: item,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                reloadAction: (_) {
                  _pagingController.refresh();
                  _librayBloc.requestData(
                    params: AlbumPlaylistRequest(
                      query: '',
                      page: 1,
                      limit: GlobalConstants.loadMoreItem,
                      sort: 'most-liked',
                      getAll: 0,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 150,
              child: WButtonInkwell(
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, AppRoute.routeCreatePlayList);
                  if (result != null) {
                    _librayBloc.requestData(
                      params: AlbumPlaylistRequest(
                        query: '',
                        page: 1,
                        limit: GlobalConstants.loadMoreItem,
                        sort: 'most-liked',
                        getAll: 0,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryButtonColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.activeEdit,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        context.l10n.t_create_playlist,
                        style: TextStyle(
                          color: AppColors.activeLabelItem,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
