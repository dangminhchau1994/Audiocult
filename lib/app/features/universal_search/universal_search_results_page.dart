import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_results_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';

import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/error_empty/widget_state.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UniversalSearchResultsPage extends StatefulWidget {
  final UniversalSearchView searchView;
  final VoidCallback screenOnLaunch;
  final Widget Function(BuildContext, UniversalSearchItem, int) itemBuilder;

  const UniversalSearchResultsPage(
    this.searchView,
    this.itemBuilder, {
    required this.screenOnLaunch,
    Key? key,
  }) : super(key: key);

  @override
  State<UniversalSearchResultsPage> createState() => UniversalSearchResultsPageState();
}

class UniversalSearchResultsPageState extends State<UniversalSearchResultsPage> with AutomaticKeepAliveClientMixin {
  final _bloc = getIt.get<UniversalSearchResultsBloc>();
  final _pagingController = PagingController<int, UniversalSearchItem>(firstPageKey: 1);
  String? _keyword;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 1) return;
      _bloc.loadMoreResults(pageKey, widget.searchView);
    });
    _bloc.searchResultsLoadedStream.listen((event) {
      event.when(
        success: (results) => searchResultsLoaded(results as List<UniversalSearchItem>),
        loading: Container.new,
        error: (error) => Container(),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.screenOnLaunch();
  }

  void searchKeywordOnChange(String keyword) {
    _keyword = keyword;
    _bloc.keywordOnChange(keyword, widget.searchView);
    _pagingController.refresh();
  }

  void searchResultsLoaded(List<UniversalSearchItem> results) {
    if (results.isNotEmpty && results.length < _bloc.litmit) {
      _pagingController.appendLastPage(results);
    } else {
      final increatePageNumber = results.isNotEmpty == true ? 1 : 0;
      _pagingController.appendPage(results, (_pagingController.nextPageKey ?? 0) + increatePageNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocHandle(bloc: _bloc, child: _resultListWidget());
  }

  Widget _resultListWidget() {
    return PagedListView<int, UniversalSearchItem>(
      padding: const EdgeInsets.all(16),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
        noItemsFoundIndicatorBuilder: (context) {
          if (_keyword?.isNotEmpty == true) {
            return EmptyDataStateWidget(null, imagePath: _iconPathForEmptyPage());
          }
          return EmptyDataStateWidget(
            context.l10n.t_input_your_keyword,
            imagePath: _iconPathForEmptyPage(),
          );
        },
        firstPageProgressIndicatorBuilder: (context) => Container(),
        newPageErrorIndicatorBuilder: (context) => const LoadingWidget(),
        itemBuilder: widget.itemBuilder,
      ),
    );
  }

  String _iconPathForEmptyPage() {
    switch (widget.searchView) {
      case UniversalSearchView.all:
        return AppAssets.icCompass;
      case UniversalSearchView.video:
      case UniversalSearchView.event:
      case UniversalSearchView.photo:
        return AppAssets.eventIcon;
      case UniversalSearchView.song:
        return AppAssets.icMusic;
      case UniversalSearchView.rssfeed:
        return AppAssets.icEnvelope;
      case UniversalSearchView.page:
        return AppAssets.icHouse;
    }
  }
}
