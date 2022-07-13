import 'dart:typed_data';

import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_background.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_input.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_map.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_search_location_input.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_tag_friend_input.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../data_source/models/requests/create_post_request.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/file/file_utils.dart';
import '../../auth/widgets/register_page.dart';
import '../../music/my_album/upload_song/upload_song_bloc.dart';

class EditFeedScreen extends StatefulWidget {
  const EditFeedScreen({
    Key? key,
    this.data,
  }) : super(key: key);

  final FeedResponse? data;

  @override
  State<EditFeedScreen> createState() => _EditFeedScreenState();
}

class _EditFeedScreenState extends State<EditFeedScreen> {
  late TextEditingController _textEditingController;
  late Uint8List iconMarker;
  final CreatePostRequest _createPostRequest = CreatePostRequest();
  final Set<Marker> _markers = {};
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());
  GoogleMapController? _googleMapController;
  String _imagePath = '';
  double _lat = 0.0;
  double _lng = 0.0;
  bool? _showTagFriends;
  bool? _showMap = false;
  bool? _enableBackground;

  @override
  void initState() {
    super.initState();
    _getCustomMarker();
    _initData();
  }

  void _initData() {
    _textEditingController = TextEditingController(text: widget.data?.feedStatus ?? '');
    _imagePath = widget.data?.statusBackground ?? '';
    _lat = widget.data?.locationLatlng?.latitude ?? 0.0;
    _lng = widget.data?.locationLatlng?.longitude ?? 0.0;
    _markers.add(
      Marker(
        markerId: const MarkerId(''),
        position: LatLng(
          _lat,
          _lng,
        ),
        icon: BitmapDescriptor.fromBytes(iconMarker),
      ),
    );
  }

  void _getCustomMarker() {
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        iconMarker = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.t_edit_post,
      ),
      body: Provider<UploadSongBloc>(
        create: (context) => UploadSongBloc(locator.get(), locator.get()),
        child: Stack(
          children: [
            EditFeedBackGround(
              imagePath: _imagePath,
            ),
            EditFeedInput(
              textEditingController: _textEditingController,
              onChanged: (value) {},
            ),
            EditFeedMap(
              lat: _lat,
              lng: _lng,
              controller: _googleMapController,
              markers: _markers,
              showMap: () {},
            ),
            Positioned(
              bottom: 10,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryButtonColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditFeedTagFriendInput(
                        onChooseTags: (values) {},
                        listProfile: widget.data?.friendsTagged,
                      ),
                      EditFeedSearchLocationInput(
                        searchLocation: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final result = await showSearch(
                            context: context,
                            delegate: AddressSearch(bloc: _registerBloc),
                          );
                          if (result != null) {
                            final placeDetails = await _registerBloc.getPlaceDetailFromId(result.placeId);
                            final location = await _registerBloc.getLatLng(result.description);
                            if (placeDetails != null) {
                              placeDetails.fullAddress = result.description;
                              setState(() {
                                _lat = location?.latitude ?? 0.0;
                                _lng = location?.longitude ?? 0.0;
                                _createPostRequest.latLng = '$_lat,$_lng';
                                _createPostRequest.locationName = placeDetails.fullAddress;
                                _showMap = true;
                                _enableBackground = false;
                                _markers.add(
                                  Marker(
                                    markerId: const MarkerId(''),
                                    position: LatLng(
                                      location?.latitude ?? 0.0,
                                      location?.longitude ?? 0.0,
                                    ),
                                    icon: BitmapDescriptor.fromBytes(iconMarker),
                                  ),
                                );
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
