import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/features/events/detail/event_detail_bloc.dart';
import 'package:audio_cult/app/features/events/detail/invite_friend_dialog.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/toast/toast_utils.dart';

class EventDetailAttending extends StatefulWidget {
  const EventDetailAttending({
    Key? key,
    this.rsvpId,
    this.eventId,
  }) : super(key: key);

  final String? rsvpId;
  final int? eventId;

  @override
  State<EventDetailAttending> createState() => _EventDetailAttendingState();
}

class _EventDetailAttendingState extends State<EventDetailAttending> {
  String _iconPath = '';
  String _title = '';
  String _rsvpId = '';
  final EventDetailBloc _eventDetailBloc = EventDetailBloc(locator.get());
  late SelectMenuModel _attendSelected;

  String _getIconPath(String id) {
    switch (id) {
      case '1':
        return _iconPath = AppAssets.attendStarIcon;
      case '2':
        return _iconPath = AppAssets.maybeStarIcon;
      case '3':
        return _iconPath = AppAssets.starIcon;
      default:
        return _iconPath = AppAssets.starIcon;
    }
  }

  String _getTitle(String id) {
    switch (id) {
      case '1':
        return _title = context.l10n.t_attending;
      case '2':
        return _title = context.l10n.t_maybe_attending;
      case '3':
        return _title = context.l10n.t_not_attending;
      default:
        return _title = context.l10n.t_not_attending;
    }
  }

  @override
  void initState() {
    _rsvpId = widget.rsvpId ?? '';
    _attendSelected = SelectMenuModel(id: -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing,
          vertical: kVerticalSpacing,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildComponent(
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 30,
                  ),
                  child: SvgPicture.asset(
                    _getIconPath(_rsvpId),
                  ),
                ),
                CommonDropdown(
                  hint: _getTitle(_rsvpId),
                  isBorderVisible: false,
                  selection: _attendSelected,
                  backgroundColor: Colors.transparent,
                  data: GlobalConstants.getSelectedMenu(context),
                  onChanged: (value) {
                    setState(() {
                      _attendSelected = value!;
                      _rsvpId = value.id.toString();
                      _eventDetailBloc.updateEventStatus(widget.eventId ?? 0, value.id ?? 0);
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      content: Builder(
                        builder: (context) => InviteFriendDialog(
                          eventId: widget.eventId,
                        ),
                      ),
                    ),
                  );
                },
                child: _buildComponent(
                  SvgPicture.asset(
                    AppAssets.mailIcon,
                  ),
                  Text(
                    context.l10n.t_invite_friend,
                    style: context.bodyTextPrimaryStyle()!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildComponent(Widget icon, Widget child) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.secondaryButtonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(flex: 2, child: icon),
          Expanded(flex: 4, child: child),
        ],
      ),
    );
  }
}
