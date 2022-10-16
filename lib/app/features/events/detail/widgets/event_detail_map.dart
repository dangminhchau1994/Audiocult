import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../utils/constants/app_assets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: kHorizontalSpacing,
        horizontal: kHorizontalSpacing,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: GoogleMap(
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
    );
  }
}
