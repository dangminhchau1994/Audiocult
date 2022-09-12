import 'package:audio_cult/app/features/music/albums/albums_bloc.dart';
import 'package:audio_cult/app/features/music/search/search_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/album_playlist_request.dart';
import '../../../data_source/models/responses/album/album_response.dart';
import '../../../utils/constants/app_dimens.dart';
import '../../../utils/route/app_route.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> with AutomaticKeepAliveClientMixin {
  final PagingController<int, Album> _pagingController = PagingController(firstPageKey: 1);
  late AlbumsBloc _albumsBloc;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _albumsBloc.loadData(
        AlbumPlaylistRequest(
          query: '',
          sort: 'latest',
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
        (r) => _albumsBloc.showError,
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
    _albumsBloc = getIt.get<AlbumsBloc>();
    _albumsBloc.requestData(
      params: AlbumPlaylistRequest(
        query: '',
        sort: 'latest',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
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
            _albumsBloc.requestData(
              params: AlbumPlaylistRequest(
                query: '',
                sort: 'latest',
                page: 1,
                limit: GlobalConstants.loadMoreItem,
              ),
            );
          },
          child: LoadingBuilder<AlbumsBloc, List<Album>>(
            builder: (data, _) {
              //only first page
              final isLastPage = data.length <= GlobalConstants.loadMoreItem - 1;
              if (isLastPage) {
                _pagingController.appendLastPage(data);
              } else {
                _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
              }
              return RawScrollbar(
                controller: ScrollController(),
                child: PagedListView<int, Album>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Album>(
                    firstPageProgressIndicatorBuilder: (context) => Container(),
                    newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return WButtonInkwell(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.routeDetailAlbum,
                            arguments: {
                              'album_id': item.albumId,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SearchItem(
                            album: item,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            reloadAction: (_) {
              _pagingController.refresh();
              _albumsBloc.requestData(
                params: AlbumPlaylistRequest(
                  query: '',
                  sort: 'latest',
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

  @override
  bool get wantKeepAlive => true;
}
