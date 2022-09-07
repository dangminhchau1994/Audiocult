import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/my_tickets/my_tickets_bloc.dart';
import 'package:audio_cult/app/features/events/my_tickets/my_tickets_empty_widget.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_font_sizes.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/network_image_widget/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

part 'my_ticket_item_widget.dart';

class MyTicketsScreen extends StatefulWidget {
  final VoidCallback? emptyPageAction;

  const MyTicketsScreen({Key? key, this.emptyPageAction}) : super(key: key);

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> with AutomaticKeepAliveClientMixin {
  final _bloc = getIt.get<MyTicketsBloc>();

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.initData(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      child: BlocHandle(
        bloc: _bloc,
        child: Container(
          color: AppColors.mainColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 70,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: _dropdownWidget(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: _listView(),
                ),
              ),
            ],
          ),
        ),
      ),
      onRefresh: () async {
        return _bloc.getAllMyTickets();
      },
    );
  }

  Widget _dropdownWidget() {
    return StreamBuilder<MyTicketsTimeFilter>(
      initialData: _bloc.currentFilter,
      stream: _bloc.filterChangeStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return PopupMenuButton<int>(
          color: AppColors.inputFillColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          icon: Row(
            children: [
              Text(
                data?.title ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppFontSize.size18),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(AppAssets.icArrowDown),
            ],
          ),
          itemBuilder: (context) => _bloc.filters
              .map(
                (e) => _dropdownItem(
                  filter: e.title,
                  value: e.index,
                  isSelected: e.index == _bloc.currentFilter?.index,
                ),
              )
              .toList(),
          onSelected: (value) => _bloc.filterOnChange(_bloc.filters[value]),
        );
      },
    );
  }

  PopupMenuItem<int> _dropdownItem({
    required String filter,
    required int value,
    required bool isSelected,
  }) {
    final icon = isSelected
        ? SvgPicture.asset(
            AppAssets.icAllEvents,
            width: 22,
            height: 22,
            color: Colors.white,
            fit: BoxFit.cover,
          )
        : Container();
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            filter,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: isSelected ? Colors.white : AppColors.subTitleColor),
          ),
          const SizedBox(width: 8),
          icon,
        ],
      ),
    );
  }

  Widget _listView() {
    return StreamBuilder<List<EventResponse>>(
      stream: _bloc.ticketsStream,
      builder: (_, snapshot) {
        if (snapshot.data?.isNotEmpty == true) {
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 120),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final event = snapshot.data![index];
              return MyTicketItemWidget(
                event,
                onTap: () => _listViewItemOnTap(event),
              );
            },
          );
        } else if (snapshot.data == null) {
          return const LoadingWidget();
        }
        return MyTicketsEmptyWidget(() => widget.emptyPageAction?.call());
      },
    );
  }

  void _listViewItemOnTap(EventResponse event) {
    Navigator.pushNamed(
      context,
      AppRoute.routeMyTicketsOfEvent,
      arguments: event,
    );
  }
}
