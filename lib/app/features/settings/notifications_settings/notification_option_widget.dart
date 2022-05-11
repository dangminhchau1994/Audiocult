part of 'notification_settings_widget.dart';

class NotificationOptionWidget extends StatefulWidget {
  final String title;
  final bool? state;
  final Function(bool)? stateOnchanged;

  const NotificationOptionWidget(this.title, {this.stateOnchanged, this.state, Key? key}) : super(key: key);

  @override
  State<NotificationOptionWidget> createState() => _NotificationOptionWidgetState();
}

class _NotificationOptionWidgetState extends State<NotificationOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.inputFillColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 2,
          color: AppColors.borderOutline,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          CupertinoSwitch(
            thumbColor: Colors.white,
            activeColor: AppColors.activeLabelItem,
            trackColor: Colors.grey,
            value: widget.state ?? false,
            onChanged: widget.stateOnchanged?.call,
          )
        ],
      ),
    );
  }
}
