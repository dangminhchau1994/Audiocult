part of 'my_diary_screen.dart';

class MyDiaryListWidget extends StatefulWidget {
  final List<EventResponse> events;
  final Function(double) listViewIsScrolling;

  const MyDiaryListWidget(this.events, this.listViewIsScrolling, {Key? key}) : super(key: key);

  @override
  State<MyDiaryListWidget> createState() => _MyDiaryListWidgetState();
}

class _MyDiaryListWidgetState extends State<MyDiaryListWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.listViewIsScrolling(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 225, bottom: 100),
      itemCount: max(widget.events.length, 1),
      itemBuilder: (context, index) {
        if (widget.events.isEmpty) {
          return const NoDataWidget();
        }
        final event = widget.events[index];
        return MyDiaryEventWidget(
          event,
          onTapped: () {
            if (event.eventId?.isNotEmpty != true) return;
            Navigator.pushNamed(
              context,
              AppRoute.routeEventDetail,
              arguments: {
                'event_id': int.parse(event.eventId!),
              },
            );
          },
        );
      },
    );
  }
}
