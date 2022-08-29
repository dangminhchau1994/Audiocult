part of 'my_tickets_of_event_screen.dart';

class TicketWidget extends StatelessWidget {
  final VoidCallback onTap;
  final TicketDetails details;

  const TicketWidget(this.details, {required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
      child: ClipPath(
        clipper: TicketClipper(10, 100, 0),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            color: AppColors.ebonyClay,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: LineDashedWidget(color: AppColors.mainColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _topWidget(context),
                    _bottomWidget(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _ticketNameWidget(context)),
            _ticketStatusTag(context),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ticketOrderCode(context),
            Text('${details.price} ${details.currency}'),
          ],
        )
      ],
    );
  }

  Widget _ticketNameWidget(BuildContext context) {
    return Text(
      details.ticketName?.toUpperCase() ?? '',
      style: context.textTheme().bodyMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _ticketStatusTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: TicketStatusExtension.init(details.statusCode ?? '')?.color,
      ),
      child: Text(
        details.status ?? '',
        style: context.textTheme().bodyMedium,
      ),
    );
  }

  Widget _ticketOrderCode(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppAssets.eventIcon,
          width: 20,
        ),
        const SizedBox(width: 12),
        Text(details.orderCode ?? ''),
      ],
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            _dateTimeWidget(details.dateFrom ?? '', context, isFrom: true),
            const SizedBox(height: 6),
            _dateTimeWidget(details.dateTo ?? '', context, isFrom: false),
          ],
        ),
        _qrCodeWidget(),
      ],
    );
  }

  String _formatedDateTime(String string) {
    if (string.isNotEmpty != true) return '';
    final date = DateTime.parse(string);
    return DateFormat('MMM d - h:mm a').format(date);
  }

  Widget _dateTimeWidget(String dateTime, BuildContext context, {bool? isFrom}) {
    final string = _formatedDateTime(dateTime);
    if (string.isEmpty == true) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isFrom == true ? '${context.localize.t_from}: ' : '${context.localize.t_to}: ',
          style: context.textTheme().bodySmall?.copyWith(color: AppColors.subTitleColor),
        ),
        Text(
          string,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _qrCodeWidget() {
    if (details.qrCode?.isNotEmpty != true) return Container();
    final qr = Image.memory(base64Decode(details.qrCode!));
    return SizedBox(
      height: 75,
      width: 75,
      child: qr,
    );
  }
}
