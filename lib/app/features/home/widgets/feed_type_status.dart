import 'dart:typed_data';

import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/file/file_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../w_components/loading/loading_widget.dart';

class FeedTypeStatus extends StatefulWidget {
  const FeedTypeStatus({
    Key? key,
    this.data,
  }) : super(key: key);

  final FeedResponse? data;

  @override
  State<FeedTypeStatus> createState() => _FeedTypeStatusState();
}

class _FeedTypeStatusState extends State<FeedTypeStatus> {
  late GoogleMapController _controller;
  Uint8List? _iconMarker;

  void _getCustomMarker() {
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        _iconMarker = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCustomMarker();
  }

  @override
  void dispose() {
    super.dispose();
    // _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(widget.data!, context);
  }

  Widget _buildContent(FeedResponse data, BuildContext context) {
    final isBackGround = data.statusBackground?.isEmpty ?? false;
    if (isBackGround && data.locationName == null) {
      return Text(
        data.feedStatus ?? '',
        style: context.buttonTextStyle()!.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
      );
    } else if (data.locationName != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: data.feedStatus != null,
            child: Text(
              data.feedStatus ?? '',
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 300,
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
                  data.locationLatlng?.latitude ?? 0.0,
                  data.locationLatlng?.longitude ?? 0.0,
                ),
                zoom: 10,
              ),
              markers: {
                if (_iconMarker != null)
                  Marker(
                    markerId: const MarkerId(''),
                    position: LatLng(
                      data.locationLatlng?.latitude ?? 0.0,
                      data.locationLatlng?.longitude ?? 0.0,
                    ),
                    icon: BitmapDescriptor.fromBytes(_iconMarker!),
                  )
              },
              onMapCreated: (controller) {
                _controller = controller;
                FileUtils.getJsonFile(AppAssets.nightMapJson).then((value) {
                  _controller.setMapStyle(value);
                });
              },
            ),
          ),
        ],
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: data.statusBackground ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
                child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 50),
              child: const LoadingWidget(),
            )),
            errorWidget: (
              BuildContext context,
              _,
              __,
            ) =>
                const Image(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/cover.jpg',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              data.feedStatus ?? '',
              textAlign: TextAlign.center,
              style: context.buttonTextStyle()!.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      );
    }
  }
}
