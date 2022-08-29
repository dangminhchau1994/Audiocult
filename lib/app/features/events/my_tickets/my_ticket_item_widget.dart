part of 'my_tickets_screen.dart';

class MyTicketItemWidget extends StatelessWidget {
  final EventResponse event;
  final VoidCallback? onTap;

  const MyTicketItemWidget(this.event, {this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: _body(event, context));
  }

  Widget _body(EventResponse event, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        children: [
          NetworkImageWidget(
            event.imagePath ?? '',
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _numberOfTicketsTag(event.tickets?.length ?? 0, context),
                  _dateTimeWidget(context),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleWidget(event.title ?? '', context),
                const SizedBox(height: 8),
                _subtitleWidget(event.location ?? '', context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _titleWidget(String text, BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _subtitleWidget(String text, BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppAssets.locationIcon,
          width: 14,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppColors.subTitleColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _numberOfTicketsTag(int number, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.activeLabelItem,
      ),
      child: Text('$number ${(number > 1) ? context.localize.t_tickets : context.localize.t_ticket}'),
    );
  }

  Widget _dateTimeWidget(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          _dateWidget(context),
          const SizedBox(height: 4),
          _timeWidget(context),
        ],
      ),
    );
  }

  Widget _dateWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.mainColor,
      ),
      child: Text(
        DateFormat('MMMd').format(DateTime.fromMillisecondsSinceEpoch(int.parse(event.timeStamp ?? '0') * 1000)),
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _timeWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.icClock,
            color: Colors.black,
            width: 18,
          ),
          const SizedBox(width: 4),
          Text(
            DateFormat.j().format(DateTime.fromMillisecondsSinceEpoch(int.parse(event.timeStamp ?? '0') * 1000)),
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
