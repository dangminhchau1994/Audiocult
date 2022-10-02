import 'dart:convert';

import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/models/responses/ticket_details/ticket_details.dart';
import 'package:audio_cult/app/features/events/my_tickets_of_event/ticket_status.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/dashed_line_widget/dashed_line_widget.dart';
import 'package:audio_cult/w_components/network_image_widget/network_image_widget.dart';
import 'package:audio_cult/w_components/ticket_clipper/ticket_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TicketDetailsWidget extends StatelessWidget {
  final TicketDetails ticketDetails;
  final EventResponse event;
  // ignore: avoid_field_initializers_in_const_classes
  final _eventInfoSectionHeight = 330.0;

  const TicketDetailsWidget(
    this.ticketDetails,
    this.event, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.mainColor,
      child: SafeArea(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipPath(
        clipper: TicketClipper(15, _eventInfoSectionHeight, 1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.ebonyClay,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _eventInfoSectionHeight,
                child: Stack(children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _eventInfoBackground()),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _eventInfoWidget(context)),
                  Positioned(
                      right: 20, top: 20, child: _statusAndPriceTagsOfTicket()),
                  Positioned(
                    top: _eventInfoSectionHeight,
                    left: 20,
                    right: 20,
                    child: LineDashedWidget(color: AppColors.badgeColor),
                  ),
                ]),
              ),
              Expanded(child: Center(child: _ticketInfoWidget(context))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _eventInfoBackground() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: NetworkImageWidget(event.imagePath ?? ''),
    );
  }

  Widget _eventInfoWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.ebonyClay.withOpacity(0.95), Colors.transparent],
          stops: const [0.6, 1.0],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          tileMode: TileMode.repeated,
        ),
      ),
      child: Container(
        height: _eventInfoSectionHeight,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ticketNameWidget(context),
            _eventTitleWidget(context),
            _locationWidget(),
            _dateTimeWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _statusAndPriceTagsOfTicket() {
    return Row(
      children: [
        _statusTag(
            status: ticketDetails.status ?? '',
            statusCode: ticketDetails.statusCode ?? ''),
        const SizedBox(width: 8),
        _priceTag(),
      ],
    );
  }

  Widget _ticketInfoWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _qrCodeWidget(),
        const SizedBox(height: 16),
        _ticketSecretWidget(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${context.localize.t_code}: ',
              style: context
                  .textTheme()
                  .caption
                  ?.copyWith(color: AppColors.subTitleColor),
            ),
            Text(ticketDetails.orderCode ?? ''),
          ],
        )
      ],
    );
  }

  Widget _eventTitleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
      child: Text(
        event.title ?? '',
        style: context.headerStyle1()?.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _ticketNameWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
      child: Text(
        ticketDetails.ticketName ?? '',
        style: context.headerStyle1()?.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _locationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.locationIcon,
            width: 16,
          ),
          const SizedBox(width: 12),
          Text(event.location ?? ''),
        ],
      ),
    );
  }

  Widget _dateTimeWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppAssets.icClock,
          width: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatedDateTime(context, dateTime: event.startDateTime),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                _formatedDateTime(context, dateTime: event.endDateTime),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatedDateTime(BuildContext context, {DateTime? dateTime}) {
    if (dateTime == null) return '';
    return DateFormat.yMMMMd(context.language?.locale)
        .add_jm()
        .format(dateTime);
  }

  Widget _statusTag({required String status, required String statusCode}) {
    final color = TicketStatusExtension.init(statusCode)?.color;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Center(child: Text(status)),
    );
  }

  Widget _priceTag() {
    final status = TicketStatusExtension.init(ticketDetails.statusCode ?? '');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: status == TicketStatus.paid
            ? status?.color
            : AppColors.subTitleColor,
      ),
      child: Center(
          child: Text('${ticketDetails.price} ${ticketDetails.currency}')),
    );
  }

  Widget _ticketSecretWidget() {
    return Padding(
      padding: const EdgeInsets.all(kHorizontalSpacing),
      child: Text(
        ticketDetails.ticketSecret ?? '',
        maxLines: 2,
      ),
    );
  }

  Widget _qrCodeWidget() {
    if (ticketDetails.qrCode?.isNotEmpty != true) return Container();
    final qr = Image.memory(base64Decode(ticketDetails.qrCode!));
    return qr;
  }
}
