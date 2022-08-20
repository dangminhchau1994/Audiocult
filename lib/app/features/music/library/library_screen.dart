import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/features/music/library/library_bloc.dart';
import 'package:audio_cult/app/features/music/library/update_playlist_params.dart';
import 'package:audio_cult/app/features/music/library/widgets/empty_playlist.dart';
import 'package:audio_cult/app/features/music/search/search_item.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/album_playlist_request.dart';
import '../../../data_source/models/responses/playlist/playlist_response.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../../../utils/toast/toast_utils.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({
    Key? key,
    this.hasAppBar = false,
    this.songId,
  }) : super(key: key);

  final bool? hasAppBar;
  final String? songId;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with AutomaticKeepAliveClientMixin, DisposableStateMixin {
  final PagingController<int, PlaylistResponse> _pagingController = PagingController(firstPageKey: 1);
  late LibraryBloc _libraryBloc;

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
    _libraryBloc = Provider.of<LibraryBloc>(context, listen: false);
    _libraryBloc.requestData(
      params: AlbumPlaylistRequest(
        query: '',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        sort: 'latest',
        getAll: 0,
      ),
    );
    _libraryBloc.addPlaylistStream.listen((profile) {
      ToastUtility.showSuccess(context: context, message: 'Added To PlayList!');
      Navigator.pop(context);
    }).disposeOn(disposeBag);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _libraryBloc.loadData(
        AlbumPlaylistRequest(
          query: '',
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          sort: 'latest',
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
        (r) => _libraryBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _goToPlayListDetail(PlaylistResponse item) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoute.routeDetailPlayList,
      arguments: {'playlist_id': item.playlistId},
    );
    if (result != null) {
      _pagingController.refresh();
      _libraryBloc.requestData(
        params: AlbumPlaylistRequest(
          query: '',
          page: 1,
          limit: GlobalConstants.loadMoreItem,
          sort: 'latest',
          getAll: 0,
        ),
      );
    }
  }

  void _addToPlayList(PlaylistResponse item, String songId) {
    _libraryBloc.addToPlaylist(item.playlistId ?? '', songId);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        height: widget.hasAppBar! ? 50 : 0,
        title: widget.hasAppBar! ? context.localize.t_my_playlist : '',
      ),
      body: BlocHandle(
        bloc: _libraryBloc,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kHorizontalSpacing - 10,
            vertical: kVerticalSpacing - 10,
          ),
          child: Column(
            children: [
              Expanded(
                flex: widget.hasAppBar! ? 8 : 2,
                child: RefreshIndicator(
                  color: AppColors.primaryButtonColor,
                  backgroundColor: AppColors.secondaryButtonColor,
                  onRefresh: () async {
                    _pagingController.refresh();
                    _libraryBloc.requestData(
                      params: AlbumPlaylistRequest(
                        query: '',
                        page: 1,
                        limit: GlobalConstants.loadMoreItem,
                        sort: 'latest',
                        getAll: 0,
                      ),
                    );
                  },
                  child: LoadingBuilder<LibraryBloc, List<PlaylistResponse>>(
                    builder: (data, _) {
                      if (data.isEmpty) {
                        return EmptyPlayList(
                          title: context.localize.t_empty_playlist,
                          content: context.localize.t_create_first_playlist,
                        );
                      }
                      //only first page
                      final isLastPage = data.length <= GlobalConstants.loadMoreItem - 1;
                      if (isLastPage) {
                        _pagingController.appendLastPage(data);
                      } else {
                        _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
                      }
                      return Scrollbar(
                        child: PagedListView<int, PlaylistResponse>.separated(
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
                                  widget.hasAppBar!
                                      ? _addToPlayList(item, widget.songId ?? '')
                                      : _goToPlayListDetail(item);
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
                      _libraryBloc.requestData(
                        params: AlbumPlaylistRequest(
                          query: '',
                          page: 1,
                          limit: GlobalConstants.loadMoreItem,
                          sort: 'latest',
                          getAll: 0,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.hasAppBar! ? 10 : 150),
                    child: WButtonInkwell(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(context, AppRoute.routeCreatePlayList,
                            arguments: {'update_playlist_params': UpdatePlaylistParams(title: '')});
                        if (result != null) {
                          _pagingController.refresh();
                          _libraryBloc.requestData(
                            params: AlbumPlaylistRequest(
                              query: '',
                              page: 1,
                              limit: GlobalConstants.loadMoreItem,
                              sort: 'latest',
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
                              context.localize.t_create_playlist,
                              style: TextStyle(
                                color: AppColors.activeLabelItem,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
