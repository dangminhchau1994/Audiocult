import 'dart:typed_data';

import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/file/file_utils.dart';

class AboutPage extends StatefulWidget {
  final ProfileData? profile;
  final ScrollController scrollController;

  const AboutPage({Key? key, this.profile, required this.scrollController}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late GoogleMapController _controller;
  Uint8List? _iconMarker;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(() {
    //   widget.scrollController
    //       .animateTo(_scrollController.offset, duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    // });
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        _iconMarker = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biography'.toUpperCase(),
              style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(widget.profile?.biography ?? ''),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                Text(
                  'Audio Artist Category:'.toUpperCase(),
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline),
                ),
                Wrap(
                  children: widget.profile?.audioArtistCategory
                          ?.map<Widget>((e) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Text('$e,'),
                              ))
                          .toList() ??
                      [],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              children: [
                Text(
                  'Favorite Genres Of Music:'.toUpperCase(),
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline),
                ),
                Wrap(
                  children: widget.profile?.favoriteGenresOfMusic
                          ?.map<Widget>((e) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Text('$e,'),
                              ))
                          .toList() ??
                      [],
                )
              ],
            ),
            SizedBox(
              height: 500,
              child: AbsorbPointer(
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
                      double.parse(widget.profile?.lat ?? '0.0'),
                      double.parse(widget.profile?.lng ?? '0.0'),
                    ),
                    zoom: 10,
                  ),
                  markers: {
                    if (_iconMarker != null)
                      Marker(
                        markerId: const MarkerId(''),
                        position: LatLng(
                          double.parse(widget.profile?.lat ?? '0.0'),
                          double.parse(widget.profile?.lng ?? '0.0'),
                        ),
                        icon: BitmapDescriptor.fromBytes(_iconMarker!),
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
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
