import 'dart:typed_data';

import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../w_components/comment/comment_args.dart';
import '../../../../../w_components/comment/comment_list_screen.dart';
import '../../../../../w_components/reactions/common_reaction.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/file/file_utils.dart';
import '../../../../utils/route/app_route.dart';
import '../../../../utils/toast/toast_utils.dart';

class EventDetailMap extends StatefulWidget {
  final Uint8List? iconMarker;
  final EventResponse? data;

  const EventDetailMap({
    Key? key,
    this.iconMarker,
    this.data,
  }) : super(key: key);

  @override
  State<EventDetailMap> createState() => _EventDetailMapState();
}

class _EventDetailMapState extends State<EventDetailMap> {
  late GoogleMapController _controller;

  Widget _buildIcon(Widget icon, String value, BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryButtonColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 14,
            ),
            Text(
              value,
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kVerticalSpacing,
          horizontal: kHorizontalSpacing,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: GoogleMap(
                gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    EagerGestureRecognizer.new,
                  ),
                },
                onTap: (lng) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(widget.data?.lat ?? '0.0'),
                    double.parse(widget.data?.lng ?? '0.0'),
                  ),
                  zoom: 10,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId(''),
                    position: LatLng(
                      double.parse(widget.data?.lat ?? '0.0'),
                      double.parse(widget.data?.lng ?? '0.0'),
                    ),
                    icon: BitmapDescriptor.fromBytes(widget.iconMarker!),
                  ),
                },
                onMapCreated: (controller) {
                  _controller = controller;
                  FileUtils.getJsonFile(AppAssets.nightMapJson).then((value) {
                    _controller.setMapStyle(value);
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CommonReactions(
                  reactionType: ReactionType.event,
                  itemId: widget.data?.eventId ?? '',
                  totalLike: widget.data?.totalLike ?? '',
                  iconPath: widget.data?.lastIcon?.imagePath,
                ),
                const SizedBox(
                  width: 10,
                ),
                WButtonInkwell(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.routeCommentListScreen,
                      arguments: CommentArgs(
                        itemId: int.parse(widget.data?.eventId ?? ''),
                        title: widget.data?.title ?? '',
                        commentType: CommentType.event,
                        data: null,
                      ),
                    );
                  },
                  child: _buildIcon(
                    SvgPicture.asset(AppAssets.commentIcon),
                    widget.data?.totalComment ?? '',
                    context,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // WButtonInkwell(
                //   onPressed: () {
                //     ToastUtility.showPending(
                //       context: context,
                //       message: context.localize.t_feature_development,
                //     );
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: AppColors.secondaryButtonColor,
                //     ),
                //     padding: const EdgeInsets.all(12),
                //     child: Center(
                //       child: SvgPicture.asset(AppAssets.shareIcon),
                //     ),
                //   ),
                // )
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
