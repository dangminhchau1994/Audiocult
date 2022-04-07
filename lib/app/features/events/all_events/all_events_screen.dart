import 'package:audio_cult/app/features/events/all_event_bloc.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/all_events.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/popular_events.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/show_events.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../popular_event_bloc.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({Key? key}) : super(key: key);

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> with AutomaticKeepAliveClientMixin {
  final PagingController<int, EventResponse> _pagingAllEventController = PagingController(firstPageKey: 1);
  final PagingController<int, EventResponse> _pagePopularEventController = PagingController(firstPageKey: 1);

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          _pagePopularEventController.refresh();
          _pagingAllEventController.refresh();
          getIt<AllEventBloc>().requestData(params: EventRequest(page: 1, limit: GlobalConstants.loadMoreItem));
          getIt<PopularEventBloc>().requestData(
            params: EventRequest(
              query: '',
              sort: 'most-liked',
              page: 1,
              limit: GlobalConstants.loadMoreItem,
            ),
          );
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: kVerticalSpacing,
              horizontal: kHorizontalSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShowEvents(),
                const SizedBox(height: 40),
                PopularEvents(pagingController: _pagePopularEventController),
                const SizedBox(height: 20),
                AllEvents(pagingController: _pagingAllEventController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
