import 'package:audio_cult/app/features/events/calendar/calendar_bloc.dart';
import 'package:audio_cult/app/features/events/calendar/widgets/calendar_event_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/debouncer.dart';
import '../../../utils/route/app_route.dart';
import '../../music/library/widgets/empty_playlist.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late TextEditingController editingController;
  late FocusNode focusNode;
  late Debouncer debouncer;
  late CalendarBloc _calendarBloc;
  final ValueNotifier<String> _text = ValueNotifier<String>('');
  final PagingController<int, EventResponse> _pagingController = PagingController(firstPageKey: 1);
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime currentDate = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd = DateTime.now();
  bool _todaySelected = true;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    debouncer = Debouncer(milliseconds: 500);
    editingController = TextEditingController(text: '');
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _calendarBloc = getIt.get<CalendarBloc>();
    callData('', 1, currentDate, currentDate);
  }

  void callData(String query, int page, DateTime startDate, DateTime endDate) {
    _pagingController.refresh();
    _calendarBloc.requestData(
      params: EventRequest(
        query: query,
        sort: 'most-liked',
        startTime: DateFormat('yyyy/MM/dd 00:00').format(startDate),
        endTime: DateFormat('yyyy/MM/dd 23:59').format(endDate),
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _calendarBloc.loadData(
        EventRequest(
          query: _text.value,
          sort: 'most-liked',
          startTime: DateFormat('yyyy/MM/dd 00:00').format(_rangeStart!),
          endTime: DateFormat('yyyy/MM/dd 23:59').format(_rangeEnd!),
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
        (r) => _calendarBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_calendar,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryButtonColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(kHorizontalSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSearchInput(),
                      const SizedBox(width: 10),
                      _buildFilter(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTableCalendar(),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryButtonColor,
              backgroundColor: AppColors.secondaryButtonColor,
              onRefresh: () async {
                _pagingController.refresh();
                callData(_text.value, 1, _rangeStart!, _rangeEnd!);
              },
              child: LoadingBuilder<CalendarBloc, List<EventResponse>>(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    pagingController: _pagingController,
                    separatorBuilder: (context, index) => const Divider(height: 24),
                    builderDelegate: PagedChildBuilderDelegate<EventResponse>(
                      firstPageProgressIndicatorBuilder: (context) => Container(),
                      newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                      animateTransitions: true,
                      itemBuilder: (context, item, index) {
                        return CalendarEventItem(
                          data: item,
                        );
                      },
                    ),
                  );
                },
                reloadAction: (_) {
                  _pagingController.refresh();
                  callData('', 1, currentDate, currentDate);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return WButtonInkwell(
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.routeFilterEvent);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.inputFillColor,
        ),
        child: SvgPicture.asset(
          AppAssets.filterIcon,
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: currentDate,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
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
          color: _todaySelected ? AppColors.activeLabelItem : Colors.transparent,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.activeLabelItem,
          shape: BoxShape.circle,
        ),
      ),
      rangeSelectionMode: _rangeSelectionMode,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            currentDate = focusedDay;
            _rangeStart = null; // Important to clean those
            _rangeEnd = null;
            _todaySelected = false;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          currentDate = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _todaySelected = false;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
        });
        callData('', 1, _rangeStart!, _rangeEnd!);
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        currentDate = focusedDay;
      },
    );
  }

  Widget _buildSearchInput() {
    return Flexible(
      child: ValueListenableBuilder<String>(
        valueListenable: _text,
        builder: (context, query, child) {
          return TextField(
            controller: editingController,
            cursorColor: Colors.white,
            onChanged: (value) {
              _text.value = value;
              callData(_text.value, 1, _rangeStart!, _rangeEnd!);
            },
            decoration: InputDecoration(
              filled: true,
              focusColor: AppColors.outlineBorderColor,
              fillColor: AppColors.inputFillColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              hintText: context.l10n.t_search,
              prefixIcon: GestureDetector(
                onTap: () {
                  if (query.isNotEmpty) {
                    callData(query, 1, _rangeStart!, _rangeEnd!);
                  }
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              suffixIcon: query.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        focusNode.unfocus();
                        editingController.text = '';
                        _text.value = '';
                        callData('', 1, _rangeStart!, _rangeEnd!);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 18,
                      ),
                    )
                  : const SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
