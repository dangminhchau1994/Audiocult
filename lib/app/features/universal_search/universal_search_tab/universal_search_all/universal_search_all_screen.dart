import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_tab/universal_search_all/universal_search_all_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/error_empty/widget_state.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UniversalSearchAllScreen extends StatefulWidget {
  const UniversalSearchAllScreen({Key? key}) : super(key: key);

  @override
  State<UniversalSearchAllScreen> createState() => UniversalSearchAllScreenState();
}

class UniversalSearchAllScreenState extends State<UniversalSearchAllScreen> with AutomaticKeepAliveClientMixin {
  final _bloc = getIt.get<UniversalSearchAllBloc>();
  final _pagingController = PagingController<int, UniversalSearchItem>(firstPageKey: 1);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_bloc.loadMoreResults);
    _bloc.searchResultsLoadedStream.listen((event) {
      event.when(
        success: (results) => searchResultOnChange(results as List<UniversalSearchItem>),
        loading: Container.new,
        error: (error) => Container(),
      );
    });
  }

  void searchKeywordOnChange(String keyword) {
    _bloc.keywordOnChange(keyword);
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
          itemBuilder: (context, item, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _resultWidget(
                imageUrl: item.itemPhoto ?? '',
                title: item.itemTitle ?? '',
                subtitle: item.itemName ?? '',
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _resultWidget({required String imageUrl, required String title, required String subtitle}) {
    return Row(
      children: [
        _imageWidget(imageUrl),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.body1TextStyle(),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle.toUpperCase(),
                style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageWidget(String imageUrl) {
    return CachedNetworkImage(
      width: 70,
      height: 70,
      imageUrl: imageUrl,
      imageBuilder: (_, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => const Image(
        image: AssetImage(AppAssets.imagePlaceholder),
        fit: BoxFit.cover,
      ),
      placeholder: (_, __) => const LoadingWidget(),
    );
  }
}
