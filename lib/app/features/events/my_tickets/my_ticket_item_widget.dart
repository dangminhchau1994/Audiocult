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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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

  Widget _dateTimeWidget(BuildContext context) {
    return SizedBox(
      width: 90,
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
      child: event.startDateTime != null
          ? Text(
              DateFormat.MMMd(context.language?.locale).format(event.startDateTime!),
              style: context.headerStyle()?.copyWith(fontSize: AppFontSize.size16),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          : Container(),
    );
  }

  Widget _timeWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.icClock, color: AppColors.mainColor, width: 16),
          const SizedBox(width: 2),
          if (event.startDateTime != null)
            _fittedTextWidget(
              DateFormat.jm(context.language?.locale).format(event.startDateTime!),
              style: context.body2TextStyle()?.copyWith(color: AppColors.mainColor),
            )
          else
            Container(),
        ],
      ),
    );
  }

  Widget _fittedTextWidget(String string, {TextStyle? style, BoxFit? boxFit}) {
    return Flexible(
      child: FittedBox(
        fit: boxFit ?? BoxFit.scaleDown,
        child: Text(
          string,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
