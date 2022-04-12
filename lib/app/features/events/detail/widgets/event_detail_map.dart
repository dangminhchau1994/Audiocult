import 'dart:typed_data';

import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/file/file_utils.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryButtonColor,
      ),
      padding: const EdgeInsets.all(12),
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
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kVerticalSpacing,
        horizontal: kHorizontalSpacing,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 500,
            child: GoogleMap(
              onTap: (lng) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(widget.data?.lat ?? ''),
                  double.parse(widget.data?.lng ?? ''),
                ),
                zoom: 10,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId(''),
                  position: LatLng(
                    double.parse(widget.data?.lat ?? ''),
                    double.parse(widget.data?.lng ?? ''),
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
              _buildIcon(
                SvgPicture.asset(AppAssets.heartIcon),
                widget.data?.totalLike ?? '',
                context,
              ),
              const SizedBox(
                width: 10,
              ),
              _buildIcon(
                SvgPicture.asset(AppAssets.commentIcon),
                widget.data?.totalComment ?? '',
                context,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondaryButtonColor,
                ),
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: SvgPicture.asset(AppAssets.shareIcon),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
