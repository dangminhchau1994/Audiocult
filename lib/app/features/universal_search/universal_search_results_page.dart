import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_results_bloc.dart';

import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/error_empty/widget_state.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UniversalSearchResultsPage extends StatefulWidget {
  final UniversalSearchView searchView;
  final Widget Function(BuildContext, UniversalSearchItem, int) itemBuilder;

  const UniversalSearchResultsPage(this.searchView, this.itemBuilder, {Key? key}) : super(key: key);

  @override
  State<UniversalSearchResultsPage> createState() => UniversalSearchResultsPageState();
}

class UniversalSearchResultsPageState extends State<UniversalSearchResultsPage> with AutomaticKeepAliveClientMixin {
  final _bloc = getIt.get<UniversalSearchResultsBloc>();
  final _pagingController = PagingController<int, UniversalSearchItem>(firstPageKey: 1);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.loadMoreResults(pageKey, widget.searchView);
    });
    _bloc.searchResultsLoadedStream.listen((event) {
      event.when(
        success: (results) => searchResultOnChange(results as List<UniversalSearchItem>),
        loading: Container.new,
        error: (error) => Container(),
      );
    });
  }

  void searchKeywordOnChange(String keyword) {
    _bloc.keywordOnChange(keyword, widget.searchView);
    _pagingController.refresh();
  }

  void searchResultOnChange(List<UniversalSearchItem> results) {
    if (results.length < _bloc.litmit) {
      _pagingController.appendLastPage(results);
    } else {
      _pagingController.appendPage(results, (_pagingController.nextPageKey ?? 0) + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocHandle(bloc: _bloc, child: _resultListWidget());
  }

  Widget _resultListWidget() {
    return Scrollbar(
      child: PagedListView<int, UniversalSearchItem>(
        padding: const EdgeInsets.all(16),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
          noItemsFoundIndicatorBuilder: (context) => const EmptyDataStateWidget(null),
          firstPageProgressIndicatorBuilder: (context) => Container(),
          newPageErrorIndicatorBuilder: (context) => const LoadingWidget(),
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}
