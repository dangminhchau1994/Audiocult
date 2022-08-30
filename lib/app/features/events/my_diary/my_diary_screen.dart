import 'dart:math';

import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/event_view_wrapper.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_bloc.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_event_widget.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/di/bloc_locator.dart';

import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuple/tuple.dart';
import '../../../utils/debouncer.dart';

part 'my_diary_calendar_widget.dart';
part 'my_diary_list_widget.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

  @override
  State<MyDiaryScreen> createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> with AutomaticKeepAliveClientMixin {
  late MyDiaryBloc _bloc;
  final _searchTextController = TextEditingController();
  final _scrollController = ScrollController();
  final _debouncer = Debouncer(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<MyDiaryBloc>();
    _bloc.loadInitialEvents();
    _searchTextController.addListener(() {
      _debouncer.run(() => _bloc.keywordOnChanged(_searchTextController.text));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.initMetadataOfEventView(context);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WKeyboardDismiss(
      child: BlocHandle(
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
      child: StreamBuilder<List<EventViewWrapper>>(
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
            onTap: () => _bloc.filterEventsByView(e),
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
        onPressed: _navigateToMyDiaryInMonth,
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

  void _navigateToMyDiaryInMonth() {
    Navigator.pushNamed(
      context,
      AppRoute.routeMyDiaryOnMonth,
      arguments: MyDiaryEventRequest()
        ..title = _searchTextController.text
        ..view = _bloc.currentEventView,
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: context.localize.t_search,
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
      stream: _bloc.dateTimeInRangeStream,
      builder: (_, data) {
        Tuple2<DateTime?, DateTime?>? dateTimeInRange;
        if (data.hasData) {
          dateTimeInRange = data.data! as Tuple2<DateTime?, DateTime?>;
        }
        return MyDiaryCalendarWidget(
          locale: _bloc.appLanguageId,
          startDateInRange: dateTimeInRange?.item1,
          endDateInRange: dateTimeInRange?.item2,
          focusRangeDateOnChanged: (dateInRange) {
            _bloc.dateTimeRangeOnChanged(startDate: dateInRange.item1, endDate: dateInRange.item2);
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
          final events = data as List<EventResponse>;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.idle) {
                  return true;
                }
                _bloc.viewStartScrolling(notification.direction == ScrollDirection.forward);
                return true;
              },
              child: events.isEmpty
                  ? const NoDataWidget()
                  : MyDiaryListWidget(
                      events,
                      (offset) {
                        _bloc.viewIsScrolling(offset);
                      },
                    ),
            ),
          );
        }, loading: () {
          return const LoadingWidget();
        }, error: (error) {
          return ErrorSectionWidget(
            errorMessage: error,
            onRetryTap: () {},
          );
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
