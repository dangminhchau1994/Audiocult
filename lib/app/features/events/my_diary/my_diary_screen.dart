import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/event_view_entity.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_bloc.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_event_widget.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:table_calendar/table_calendar.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

  @override
  State<MyDiaryScreen> createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> with AutomaticKeepAliveClientMixin {
  late MyDiaryBloc _bloc;
  final _searchTextController = TextEditingController();
  final _pagingController = PagingController<int, EventResponse>(firstPageKey: 1);
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<MyDiaryBloc>();

    _pagingController.addPageRequestListener((pageKey) {
      _bloc.loadEvents(pageNumber: pageKey);
    });
    _bloc.myEventsStream.listen(
      (state) {
        state.whenOrNull(
          success: (data) {
            final events = data as List<EventResponse>;
            _pagingController.appendLastPage(events);
          },
          error: (error) {
            _pagingController.error = error;
          },
        );
      },
    );
    _bloc.loadEvents(pageNumber: 1);
    _scrollController.addListener(() {
      _bloc.viewIsScrolling(_scrollController.offset);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.initMetadataOfEventView(context);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocHandle(
      bloc: _bloc,
      child: Container(
        color: AppColors.mainColor,
        child: Stack(
          children: [
            _listView(),
            _animatedTopWidget(),
          ],
        ),
      ),
    );
  }

  Widget _animatedTopWidget() {
    return StreamBuilder<bool>(
      stream: _bloc.viewScrollStream,
      initialData: true,
      builder: (context, snapshot) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: snapshot.data! ? 0 : -70,
          left: 0,
          right: 0,
          height: 225,
          child: _topWidget(),
        );
      },
    );
  }

  Widget _topWidget() {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: AppColors.ebonyClay.withAlpha(140),
          ).frosted(blur: 3, frostColor: Colors.black),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 38,
                  child: Row(
                    children: [
                      Expanded(child: _searchTextField()),
                      const SizedBox(width: 8),
                      _eventViewButton(),
                      const SizedBox(width: 8),
                      _fullCalendarButton(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _calendarWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _eventViewButton() {
    return Container(
      width: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: AppColors.ebonyClay,
      ),
      child: StreamBuilder<List<EventViewEntity>>(
        stream: _bloc.eventViewStream,
        initialData: const [],
        builder: (_, snapshot) {
          return PopupMenuButton(
            color: AppColors.ebonyClay,
            icon: SvgPicture.asset(AppAssets.eventActiveIcon),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text(
                  'Show:',
                  style: context.body2TextStyle(),
                ),
              ),
              ..._eventViewsOptions(),
            ],
          );
        },
      ),
    );
  }

  List<PopupMenuEntry> _eventViewsOptions() {
    return _bloc.eventViews
        .map(
          (e) => PopupMenuItem(
            onTap: () {
              _bloc.filterEventsByView(e);
              _pagingController.refresh();
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  e.view.iconPath,
                  color: e.isSelected ? AppColors.activeLabelItem : Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  e.view.title(context),
                  style:
                      context.body1TextStyle()?.copyWith(color: e.isSelected ? AppColors.activeLabelItem : Colors.grey),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _fullCalendarButton() {
    return Container(
      width: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: AppColors.ebonyClay,
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoute.routeMyDiaryOnMonth,
          );
        },
        icon: Container(
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: AppColors.ebonyClay,
          ),
          child: SvgPicture.asset(
            AppAssets.calendarIcon,
            width: 18,
            color: AppColors.persianGreen,
          ),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.ebonyClay,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.whiteSearchIcon,
            width: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 1),
              child: TextField(
                controller: _searchTextController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarWidget() {
    return StreamBuilder(
      stream: _bloc.currentDateTimeStream,
      builder: (_, data) {
        var selectedDateTime = DateTime.now();
        if (data.hasData) {
          selectedDateTime = data.data! as DateTime;
        }
        return TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: selectedDateTime,
          selectedDayPredicate: (day) => isSameDay(selectedDateTime, day),
          calendarFormat: CalendarFormat.week,
          headerVisible: true,
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white),
          ),
          calendarStyle: CalendarStyle(
            disabledTextStyle: const TextStyle(color: Colors.white),
            selectedTextStyle: const TextStyle(color: Colors.white),
            weekendTextStyle: const TextStyle(color: Colors.white),
            rangeStartDecoration: BoxDecoration(
              color: AppColors.activeLabelItem,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: AppColors.activeLabelItem,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: isSameDay(selectedDateTime, DateTime.now()) ? AppColors.activeLabelItem : Colors.transparent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: AppColors.activeLabelItem,
              shape: BoxShape.circle,
            ),
          ),
          rangeSelectionMode: RangeSelectionMode.disabled,
          onDaySelected: (selectedDay, _) {
            _bloc.dateTimeOnChanged(selectedDay);
            _pagingController.refresh();
          },
        );
      },
    );
  }

  Widget _listView() {
    return StreamBuilder<BlocState<List<EventResponse>>>(
        stream: _bloc.myEventsStream,
        initialData: const BlocState.loading(),
        builder: (_, snapshot) {
          final state = snapshot.data;
          return state!.when(success: (data) {
            return RefreshIndicator(
              onRefresh: refreshMyDiaryEventsList,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    if (notification.direction == ScrollDirection.idle) {
                      return true;
                    }
                    _bloc.viewStartScroll(notification.direction == ScrollDirection.forward);
                    return true;
                  },
                  child: SizedBox(
                    height: double.infinity,
                    child: PagedListView<int, EventResponse>(
                      scrollController: _scrollController,
                      padding: const EdgeInsets.only(top: 225, bottom: 100),
                      shrinkWrap: true,
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<EventResponse>(
                        itemBuilder: (context, event, index) => MyDiaryEventWidget(event),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }, loading: () {
            return const LoadingWidget();
          }, error: (error) {
            return ErrorSectionWidget(
              errorMessage: error,
              onRetryTap: () {
                _pagingController.refresh();
              },
            );
          });
        });
  }

  Future refreshMyDiaryEventsList() async {
    _pagingController.refresh();
  }

  @override
  bool get wantKeepAlive => true;
}
