import 'package:audio_cult/app/features/events/all_events/widgets/all_event_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/global_constants.dart';
import '../../../../data_source/models/requests/event_request.dart';
import '../../../../data_source/models/responses/events/event_response.dart';
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
  late PagingController<int, EventResponse> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = widget.pagingController!;
  }

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, EventResponse>.separated(
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
  }
}
