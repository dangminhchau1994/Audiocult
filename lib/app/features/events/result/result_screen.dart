import 'package:audio_cult/app/features/events/result/result_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../di/bloc_locator.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../music/library/widgets/empty_playlist.dart';
import '../all_events/widgets/all_event_item.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    this.params,
  }) : super(key: key);

  final EventRequest? params;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ResultBloc _resultBloc;
  final PagingController<int, EventResponse> _pagingController = PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _resultBloc.loadData(
        EventRequest(
          categoryId: widget.params?.categoryId,
          query: widget.params?.query,
          distance: widget.params?.distance,
          when: widget.params?.when,
          tag: widget.params?.tag,
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
        (r) => _resultBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _resultBloc = getIt.get<ResultBloc>();
    _resultBloc.requestData(
      params: EventRequest(
        categoryId: widget.params?.categoryId,
        query: widget.params?.query,
        distance: widget.params?.distance,
        when: widget.params?.when,
        tag: widget.params?.tag,
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.localize.t_result,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          _pagingController.refresh();
          getIt<ResultBloc>().requestData(
            params: EventRequest(
              categoryId: widget.params?.categoryId,
              query: widget.params?.query,
              distance: widget.params?.distance,
              when: widget.params?.when,
              tag: widget.params?.tag,
              page: 1,
              limit: GlobalConstants.loadMoreItem,
            ),
          );
        },
        child: LoadingBuilder<ResultBloc, List<EventResponse>>(
          noDataBuilder: (state) {
            return EmptyPlayList(
              title: context.localize.t_no_data_found,
              content: context.localize.t_no_data_found_content,
            );
          },
          builder: (data, _) {
            //only first page
            final isLastPage = data.length <= GlobalConstants.loadMoreItem - 1;
            if (isLastPage) {
              _pagingController.appendLastPage(data);
            } else {
              _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
            }
            return Scrollbar(
              child: PagedListView<int, EventResponse>.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                pagingController: _pagingController,
                separatorBuilder: (context, index) => const Divider(height: 24),
                builderDelegate: PagedChildBuilderDelegate<EventResponse>(
                  firstPageProgressIndicatorBuilder: (context) => Container(),
                  newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                  animateTransitions: true,
                  itemBuilder: (context, item, index) {
                    return AllEventItem(
                      data: item,
                    );
                  },
                ),
              ),
            );
          },
          reloadAction: (_) {
            _pagingController.refresh();
            _resultBloc.requestData(
              params: EventRequest(
                categoryId: widget.params?.categoryId,
                query: widget.params?.query,
                distance: widget.params?.distance,
                when: widget.params?.when,
                tag: widget.params?.tag,
                page: 1,
                limit: GlobalConstants.loadMoreItem,
              ),
            );
          },
        ),
      ),
    );
  }
}
