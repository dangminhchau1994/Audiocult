import 'package:audio_cult/app/features/events/all_events/widgets/all_event_item.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/loading/loading_builder.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/global_constants.dart';
import '../../../../data_source/models/requests/event_request.dart';
import '../../../../data_source/models/responses/events/event_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../all_event_bloc.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({
    Key? key,
    this.pagingController,
  }) : super(key: key);

  final PagingController<int, EventResponse>? pagingController;

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  late AllEventBloc _eventBloc;
  late PagingController<int, EventResponse> _pagingController;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _eventBloc.loadData(
        EventRequest(
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
        (r) => _eventBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController = widget.pagingController!;
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _eventBloc = getIt.get<AllEventBloc>();
    _eventBloc.requestData(
      params: EventRequest(
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.t_all_events,
                style: context.bodyTextStyle()?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
              ),
              WButtonInkwell(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.routeFilterEvent);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.secondaryButtonColor,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.filterIcon,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Filter',
                        style: context.bodyTextStyle()?.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 500,
            child: LoadingBuilder<AllEventBloc, List<EventResponse>>(
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
                );
              },
              reloadAction: (_) {
                _pagingController.refresh();
                _eventBloc.requestData(
                  params: EventRequest(
                    page: 1,
                    limit: GlobalConstants.loadMoreItem,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
