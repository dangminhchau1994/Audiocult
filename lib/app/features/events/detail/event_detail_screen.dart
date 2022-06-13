import 'dart:typed_data';

import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/detail/event_detail_bloc.dart';
import 'package:audio_cult/app/features/events/detail/widgets/custom_event_sliver.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_artist.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_attending.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_comment.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_description.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_festival.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_info.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_map.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_navbar.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_photo.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_title.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:flutter/material.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/file/file_utils.dart';
import '../../../utils/toast/toast_utils.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({
    Key? key,
    this.id,
    this.fromNotificatiton = false,
  }) : super(key: key);

  final int? id;
  final bool? fromNotificatiton;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late Uint8List _iconMarker;
  late final ScrollController _scrollController =
      ScrollController(initialScrollOffset: widget.fromNotificatiton ?? false ? 2200.100 : 0);
  final EventDetailBloc _eventDetailBloc = EventDetailBloc(locator.get());

  @override
  void initState() {
    super.initState();
    _eventDetailBloc.getEventDetail(widget.id ?? 0);
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        _iconMarker = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          _eventDetailBloc.getEventDetail(widget.id ?? 0);
        },
        child: StreamBuilder<BlocState<EventResponse>>(
          initialData: const BlocState.loading(),
          stream: _eventDetailBloc.getEventDetailStream,
          builder: (context, snapshot) {
            final state = snapshot.data!;

            return state.when(
              success: (success) {
                final data = success as EventResponse;

                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          EventDetailPhoto(imagePath: data.imagePath ?? ''),
                          const EventDetailNavBar(),
                          EventDetailTitle(title: data.title ?? ''),
                          EventDetailFestiVal(
                            category: data.categories?[0][0],
                          ),
                        ],
                      ),
                    ),
                    EventDetaiInfo(data: data),
                    EventDetailAttending(
                      eventId: widget.id ?? 0,
                      rsvpId: data.rsvpId,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalSpacing,
                          vertical: kVerticalSpacing,
                        ),
                        child: CommonButton(
                          color: AppColors.primaryButtonColor,
                          text: context.l10n.t_buy,
                          onTap: () {
                            ToastUtility.showPending(
                              context: context,
                              message: context.l10n.t_feature_development,
                            );
                          },
                        ),
                      ),
                    ),
                    ArtistLineUp(data: data),
                    EventDetailDescription(data: data),
                    EventDetailMap(iconMarker: _iconMarker, data: data),
                    EventDetailComment(id: widget.id, title: data.title)
                  ],
                );
              },
              loading: () {
                return const Center(
                  child: LoadingWidget(),
                );
              },
              error: (error) {
                return ErrorSectionWidget(
                  errorMessage: error,
                  onRetryTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
