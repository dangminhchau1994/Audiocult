import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
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
        margin: const EdgeInsets.all(kVerticalSpacing),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.ebonyClay,
        ),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFieldWidget(
            title: context.localize.t_your_gender,
            value: widget.profile?.gender,
          ),
          _textFieldWidget(
            title: context.localize.t_location,
            value: widget.profile?.locationString,
          ),
          _textFieldWidget(
            title: context.localize.t_last_login,
            value: widget.profile?.lastLogin,
          ),
          _textFieldWidget(
            title: context.localize.t_member_since,
            value: widget.profile?.joined,
          ),
          _textFieldWidget(
            title: context.localize.t_membership,
            value: widget.profile?.title,
          ),
          _textFieldWidget(
            title: context.localize.t_profile_views,
            value: widget.profile?.totalSubscribers?.toString(),
          ),
          Container(
            padding: const EdgeInsets.only(top: kVerticalSpacing),
            height: 500,
            child: _mapView(),
          ),
        ],
      ),
    );
  }

  Widget _mapView() {
    return AbsorbPointer(
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
    );
  }

  Widget _textFieldWidget({required String title, required String? value}) {
    if (value?.isNotEmpty != true) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor),
          ),
          const SizedBox(height: 4),
          Text(
            value!,
            style: context.bodyTextStyle(),
          )
        ],
      ),
    );
  }
}
