import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/requests/top_song_request.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/features/music/top_song/top_song_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';

class TopSongScreen extends StatefulWidget {
  const TopSongScreen({Key? key}) : super(key: key);

  @override
  State<TopSongScreen> createState() => _TopSongScreenState();
}

class _TopSongScreenState extends State<TopSongScreen> {
  final PagingController<int, Song> _pagingController = PagingController(firstPageKey: 1);
  late TopSongBloc _topSongBloc;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _topSongBloc = getIt.get<TopSongBloc>();
    _topSongBloc.requestData(
      params: TopSongRequest(
        sort: 'most-viewed',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _topSongBloc.loadData(
        TopSongRequest(
          sort: 'most-viewed',
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
        (r) => _topSongBloc.showError,
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
        title: context.l10n.t_top_song,
        actions: [
          GestureDetector(
            onTap: () {
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
          Container(
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
            _topSongBloc.requestData(
              params: TopSongRequest(
                sort: 'most-viewed',
                page: 1,
                limit: GlobalConstants.loadMoreItem,
              ),
            );
          },
          child: LoadingBuilder<TopSongBloc, List<Song>>(
            builder: (data, _) {
              //only first page
              final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
              if (isLastPage) {
                _pagingController.appendLastPage(data);
              } else {
                _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
              }
              return PagedListView<int, Song>.separated(
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
                      onMenuClick: () {},
                    );
                  },
                ),
              );
            },
            reloadAction: (_) {
              _pagingController.refresh();
              _topSongBloc.requestData(
                params: TopSongRequest(
                  sort: 'most-viewed',
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
