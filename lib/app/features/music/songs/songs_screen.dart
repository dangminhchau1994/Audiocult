import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/songs/songs_bloc.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/top_song_request.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimens.dart';
import '../../../utils/route/app_route.dart';
import '../../player_widgets/player_screen.dart';
import '../discover/widgets/song_item.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({Key? key}) : super(key: key);

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> with AutomaticKeepAliveClientMixin {
  late SongsBloc _songsBloc;
  final PagingController<int, Song> _pagingController = PagingController(firstPageKey: 1);

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _songsBloc = getIt<SongsBloc>();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _songsBloc.requestData(
      params: TopSongRequest(
        sort: 'latest',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _songsBloc.loadData(
        TopSongRequest(
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
        (r) => _songsBloc.showError,
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
          vertical: kVerticalSpacing - 10,
          horizontal: kHorizontalSpacing - 10,
        ),
        child: RefreshIndicator(
          color: AppColors.primaryButtonColor,
          backgroundColor: AppColors.secondaryButtonColor,
          onRefresh: () async {
            _pagingController.refresh();
            _songsBloc.requestData(
              params: TopSongRequest(
                sort: 'latest',
                page: 1,
                limit: GlobalConstants.loadMoreItem,
              ),
            );
          },
          child: LoadingBuilder<SongsBloc, List<Song>>(
            builder: (data, _) {
              //only first page
              final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
              if (isLastPage) {
                _pagingController.appendLastPage(data);
              } else {
                _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
              }
              return RawScrollbar(
                controller: ScrollController(),
                child: PagedListView<int, Song>.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  pagingController: _pagingController,
                  separatorBuilder: (context, index) => const Divider(height: 16),
                  builderDelegate: PagedChildBuilderDelegate<Song>(
                    firstPageProgressIndicatorBuilder: (context) => Container(),
                    newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return SongItem(
                        song: item,
                        songs: _pagingController.itemList,
                        index: index,
                        currency: _songsBloc.currency,
                      );
                    },
                  ),
                ),
              );
            },
            reloadAction: (_) {
              _songsBloc.requestData(
                params: TopSongRequest(
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
