import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/all_event_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/loading/loading_builder.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../data_source/models/requests/event_request.dart';
import '../../../music/library/widgets/empty_playlist.dart';
import '../map_bloc.dart';

class EventPopUp extends StatefulWidget {
  const EventPopUp({
    Key? key,
    this.query,
  }) : super(key: key);

  final String? query;

  @override
  State<EventPopUp> createState() => _EventPopUpState();
}

class _EventPopUpState extends State<EventPopUp> {
  late MapBloc _mapBloc;
  final PagingController<int, EventResponse> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _mapBloc = getIt<MapBloc>();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _mapBloc.requestData(
      params: EventRequest(
        query: widget.query,
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _mapBloc.loadData(
        EventRequest(
          query: widget.query,
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
        (r) => _mapBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 337,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SizedBox(
        height: 300,
        child: LoadingBuilder<MapBloc, List<EventResponse>>(
          noDataBuilder: (state) {
            return EmptyPlayList(
              title: context.l10n.t_no_data_found,
              content: context.l10n.t_no_data_found_content,
            );
          },
          builder: (data, _) {
            //only first page
            final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
            if (isLastPage) {
              _pagingController.appendLastPage(data);
            } else {
              _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
            }
            return PagedListView<int, EventResponse>.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                vertical: 51,
                horizontal: 14,
              ),
              pagingController: _pagingController,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              builderDelegate: PagedChildBuilderDelegate<EventResponse>(
                firstPageProgressIndicatorBuilder: (context) => Container(),
                newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return AllEventItem(
                    data: item,
                    width: 300,
                  );
                },
              ),
            );
          },
          reloadAction: (_) {
            _pagingController.refresh();
            _mapBloc.requestData(
              params: EventRequest(
                query: widget.query,
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
