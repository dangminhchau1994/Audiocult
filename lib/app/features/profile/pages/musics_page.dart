import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/error_empty/widget_state.dart';
import '../../music/discover/discover_bloc.dart';
import '../../music/discover/widgets/song_item.dart';

class MusicsPage extends StatefulWidget {
  final ScrollController scrollController;
  final ProfileData profile;
  const MusicsPage({Key? key, required this.scrollController, required this.profile}) : super(key: key);

  @override
  State<MusicsPage> createState() => _MusicsPageState();
}

class _MusicsPageState extends State<MusicsPage> {
  final PagingController<int, Song> _pagingController = PagingController(firstPageKey: 1);
  final ScrollController _scrollController = ScrollController();
  final DiscoverBloc _discoverBloc = DiscoverBloc(locator.get());
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.scrollController
          .animateTo(_scrollController.offset, duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    });
    _discoverBloc.getMixTapSongs('', 'sort', '', '', 1, GlobalConstants.loadMoreItem, '', '',
        userId: widget.profile.userId);
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _discoverBloc.getMixTapSongs('', 'sort', '', '', 1, GlobalConstants.loadMoreItem, '', '',
            userId: widget.profile.userId);
      }
    });
    _discoverBloc.getMixTapSongsStream.listen((data) {
      data.when(
          success: (success) {
            final data = success as List<Song>;
            final isLastPage = data.length <= GlobalConstants.loadMoreItem - 1;
            if (isLastPage) {
              _pagingController.appendLastPage(data);
            } else {
              _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
            }
          },
          loading: () {},
          error: (e) {
            _pagingController.error = e;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(kVerticalSpacing),
        child: Scrollbar(
          child: PagedListView<int, Song>(
            scrollController: _scrollController,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Song>(
              noItemsFoundIndicatorBuilder: (_) => const EmptyDataStateWidget(null),
              firstPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
              firstPageErrorIndicatorBuilder: (_) {
                return ErrorSectionWidget(
                  errorMessage: _pagingController.error as String,
                  onRetryTap: () {
                    _pagingController.refresh();
                    _discoverBloc.getMixTapSongs('', 'sort', '', '', 1, GlobalConstants.loadMoreItem, '', '',
                        userId: widget.profile.userId);
                  },
                );
              },
              itemBuilder: (context, item, index) {
                return SongItem(
                  song: item,
                  songs: _pagingController.itemList,
                  index: index,
                  currency: widget.profile.currency,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
