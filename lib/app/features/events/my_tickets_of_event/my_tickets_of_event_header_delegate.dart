part of 'my_tickets_of_event_screen.dart';

class MyTicketsOfEventHeaderDelegate extends SliverPersistentHeaderDelegate {
  final _height = 300.0;
  final EventResponse event;

  MyTicketsOfEventHeaderDelegate(this.event);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAssets.imgHeaderDrawer,
          fit: BoxFit.cover,
          height: _height,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: _height,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.mainColor, Colors.transparent],
                stops: const [0.15, 1.0],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.repeated,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _titleWidget(context),
              _locationWidget(),
              _dateTimeWidget(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _titleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
      child: Text(
        event.title ?? '',
        style: context.headerStyle1()?.copyWith(fontWeight: FontWeight.w500),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.startTimeString?.toUpperCase() ?? ''),
            const SizedBox(height: 4),
            Text(event.endTimeString?.toUpperCase() ?? ''),
          ],
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double maxExtent = 300;

  @override
  double minExtent = 180;
}
