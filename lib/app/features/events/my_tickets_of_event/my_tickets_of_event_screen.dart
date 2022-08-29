import 'dart:convert';

import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/models/responses/ticket_details/ticket_details.dart';
import 'package:audio_cult/app/features/events/my_tickets_of_event/list_view_stream_widget.dart';
import 'package:audio_cult/app/features/events/my_tickets_of_event/my_tickets_of_event_bloc.dart';
import 'package:audio_cult/app/features/events/my_tickets_of_event/ticket_status.dart';
import 'package:audio_cult/app/features/events/ticket_details_widget.dart/ticket_details_widget.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/dashed_line_widget/dashed_line_widget.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/ticket_clipper/ticket_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'my_tickets_of_event_header_delegate.dart';
part 'ticket_widget.dart';

class MyTicketsOfEventScreen extends StatefulWidget {
  final EventResponse event;

  const MyTicketsOfEventScreen(this.event, {Key? key}) : super(key: key);

  @override
  State<MyTicketsOfEventScreen> createState() => _MyTicketsOfEventScreenState();
}

class _MyTicketsOfEventScreenState extends State<MyTicketsOfEventScreen> {
  final _bloc = getIt.get<MyTicketsOfEventBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getAllTicketsOfEvent(widget.event.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: const CommonAppBar(),
      body: SafeArea(child: BlocHandle(bloc: _bloc, child: _body())),
    );
  }

  Widget _body() {
    return ListViewStreamWidget<List<TicketDetails>>(
      _bloc.allTicketsStream,
      (_, items) => _mainContentWidget(items),
      placeholder: _noDataWidget(),
      error: _errorWidget(),
    );
  }

  Widget _noDataWidget() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _eventInfoWidget(widget.event),
        const SliverFillRemaining(child: NoDataWidget()),
      ],
    );
  }

  Widget _errorWidget() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _eventInfoWidget(widget.event),
        SliverFillRemaining(
          child: ErrorSectionWidget(
            errorMessage: context.localize.t_went_wrong,
            onRetryTap: () => _bloc.getAllTicketsOfEvent(widget.event.eventId ?? ''),
          ),
        ),
      ],
    );
  }

  Widget _mainContentWidget(List<TicketDetails> items) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _eventInfoWidget(widget.event),
        _ticketListView(items),
      ],
    );
  }

  Widget _eventInfoWidget(EventResponse event) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: MyTicketsOfEventHeaderDelegate(event),
    );
  }

  Widget _ticketListView(List<TicketDetails> tickets) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return TicketWidget(
          tickets[index],
          onTap: () => showBarModalBottomSheet(
            context: context,
            builder: (_) => TicketDetailsWidget(tickets[index], widget.event),
          ),
        );
      }, childCount: tickets.length),
    );
  }
}
