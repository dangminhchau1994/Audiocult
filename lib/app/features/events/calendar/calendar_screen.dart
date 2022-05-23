import 'package:audio_cult/app/features/events/calendar/calendar_bloc.dart';
import 'package:audio_cult/app/features/events/calendar/widgets/calendar_event_list.dart';
import 'package:audio_cult/app/features/events/calendar/widgets/calendar_table.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/debouncer.dart';
import '../../../utils/extensions/app_extensions.dart';
import '../../../utils/route/app_route.dart';

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
  final _rangeStart = DateTime.now();
  final _rangeEnd = DateTime.now();
  final ValueNotifier<String> _text = ValueNotifier<String>('');
  final PagingController<int, EventResponse> _pagingController = PagingController(firstPageKey: 1);
  final List<ValueNotifier<dynamic>> _listCalendar = [
    ValueNotifier(DateTime.now()),
    ValueNotifier(DateTime(0)),
    ValueNotifier(DateTime.now()),
    ValueNotifier(DateTime.now()),
    ValueNotifier(true),
    ValueNotifier(CalendarFormat.week),
    ValueNotifier(RangeSelectionMode.toggledOn),
    ValueNotifier('')
  ];

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
    callData('', 1, DateTime.now(), DateTime.now());
  }

  void callData(String query, int page, DateTime startDate, DateTime endDate) {
    _pagingController.refresh();
    _calendarBloc.requestData(
      params: EventRequest(
        query: query,
        sort: 'latest',
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
          sort: 'latest',
          startTime: DateFormat('yyyy/MM/dd 00:00').format(_rangeStart),
          endTime: DateFormat('yyyy/MM/dd 23:59').format(_rangeEnd),
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                    CalendarTable(
                      listCalendar: _listCalendar,
                      callData: callData,
                      query: _text.value,
                    )
                  ],
                ),
              ),
            ),
            CalendarEventList(
              callData: callData,
              pagingController: _pagingController,
              rangeStart: _rangeStart,
              rangeEnd: _rangeEnd,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return Flexible(
      child: MultiValueListenableBuilder(
        valueListenables: _listCalendar,
        builder: (context, values, child) {
          final query = asType<String>(values.elementAt(7));
          final start = asType<DateTime>(values.elementAt(2));
          final end = asType<DateTime>(values.elementAt(3));

          return TextField(
            controller: editingController,
            cursorColor: Colors.white,
            onChanged: (value) {
              _listCalendar[7].value = value;
              callData(value, 1, start!, end!);
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
                  if (query!.isNotEmpty) {
                    callData(query, 1, start!, end!);
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
              suffixIcon: query!.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        focusNode.unfocus();
                        editingController.text = '';
                        _listCalendar[7].value = '';
                        callData('', 1, start!, end!);
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
}
