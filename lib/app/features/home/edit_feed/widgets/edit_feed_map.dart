import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/file/file_utils.dart';

class EditFeedMap extends StatelessWidget {
  const EditFeedMap({
    Key? key,
    this.lat,
    this.lng,
    this.markers,
    this.controller,
    this.showMap,
  }) : super(key: key);

  final double? lat;
  final double? lng;
  final Set<Marker>? markers;
  final GoogleMapController? controller;
  final Function()? showMap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: GoogleMap(
            onTap: (lng) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(lat ?? 0, lng ?? 0),
              zoom: 10,
            ),
            markers: markers ?? {},
            onMapCreated: (controller) {
              controller = controller;
              FileUtils.getJsonFile(AppAssets.nightMapJson).then((value) {
                controller.setMapStyle(value);
              });
            },
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: WButtonInkwell(
            onPressed: showMap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondaryButtonColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
