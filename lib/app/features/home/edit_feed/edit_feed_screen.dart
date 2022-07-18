import 'dart:typed_data';

import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/features/home/edit_feed/edit_feed_bloc.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_background.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_input.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_list_background.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_map.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_search_location_input.dart';
import 'package:audio_cult/app/features/home/edit_feed/widgets/edit_feed_tag_friend_input.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../constants/global_constants.dart';
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
  final CreatePostRequest _createPostRequest = CreatePostRequest();
  final Set<Marker> _markers = {};
  final _listPrivacy = GlobalConstants.listPrivacy;
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());
  late TextEditingController _textEditingController;
  late bool? _showListBackground;
  late bool? _showTagFriends;
  late bool? _showMap = false;
  late bool? _enableBackground;
  late double _lat = 0;
  late double _lng = 0;
  Uint8List? iconMarker;
  SelectMenuModel? _privacy;
  GoogleMapController? _googleMapController;
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
    _getCustomMarker();
    _initData();
    _setFlags();
  }

  void _initData() {
    _textEditingController = TextEditingController(text: widget.data?.feedStatus ?? '');
    _imagePath = widget.data?.statusBackground ?? '';
    _lat = widget.data?.locationLatlng?.latitude ?? 0.0;
    _lng = widget.data?.locationLatlng?.longitude ?? 0.0;
    _privacy = _listPrivacy[int.parse(widget.data?.privacy ?? '')];
  }

  void _setFlags() {
    _enableBackground = _imagePath.isNotEmpty;
    _showTagFriends = false;
    _showListBackground = false;
    if (_lat != 0.0 && _lng != 0.0) {
      _showMap = true;
    }
  }

  void _getCustomMarker() {
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        iconMarker = value;
        _markers.add(
          Marker(
            markerId: const MarkerId(''),
            position: LatLng(
              _lat,
              _lng,
            ),
            icon: BitmapDescriptor.fromBytes(iconMarker!),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CommonAppBar(
          title: context.l10n.t_edit_post,
          backgroundColor: AppColors.secondaryButtonColor,
        ),
        body: Provider<UploadSongBloc>(
          create: (context) => UploadSongBloc(locator.get(), locator.get()),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_enableBackground!)
                EditFeedBackGround(
                  imagePath: _imagePath,
                  textEditingController: _textEditingController,
                  onClose: () {
                    setState(() {
                      _enableBackground = false;
                      _createPostRequest.statusBackgroundId = '0';
                    });
                  },
                  onChanged: (value) {
                    _createPostRequest.userStatus = value;
                  },
                )
              else if (_showMap!)
                const SizedBox()
              else
                EditFeedInput(
                  textEditingController: _textEditingController,
                  onChanged: (value) {
                    _createPostRequest.userStatus = value;
                  },
                ),
              Visibility(
                visible: _showMap!,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EditFeedInput(
                        textEditingController: _textEditingController,
                        onChanged: (value) {},
                      ),
                      EditFeedMap(
                        lat: _lat,
                        lng: _lng,
                        controller: _googleMapController,
                        markers: _markers,
                        showMap: () {
                          setState(() {
                            _showMap = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: _showTagFriends!,
                            child: EditFeedTagFriendInput(
                              onChooseTags: (value) {
                                final sb = StringBuffer();
                                for (final item in value) {
                                  sb.write('${item.userId},');
                                }
                                _createPostRequest.taggedFriends = sb.toString();
                              },
                              listProfile: widget.data?.friendsTagged,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (_showListBackground!)
                                EditFeedListBackground(
                                  onBackgroundItemClick: (data) {
                                    setState(() {
                                      _createPostRequest.statusBackgroundId = data.backgroundId;
                                      _imagePath = data.imageUrl ?? '';
                                      _enableBackground = true;
                                      _showMap = false;
                                    });
                                  },
                                  onShowBackground: () {
                                    setState(() {
                                      _showListBackground = false;
                                    });
                                  },
                                )
                              else
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: CommonDropdown(
                                        selection: _privacy,
                                        hint: '',
                                        backgroundColor: Colors.transparent,
                                        noBorder: true,
                                        data: GlobalConstants.listPrivacy,
                                        onChanged: (value) {
                                          setState(() {
                                            _privacy = value;
                                            _createPostRequest.privacy = value?.id;
                                          });
                                        },
                                      ),
                                    ),
                                    //icon tag friend
                                    WButtonInkwell(
                                      onPressed: () {
                                        setState(() {
                                          if (_showTagFriends!) {
                                            _showTagFriends = false;
                                          } else {
                                            _showTagFriends = true;
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          AppAssets.tagFriends,
                                          width: 28,
                                          height: 28,
                                        ),
                                      ),
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
                                                  icon: BitmapDescriptor.fromBytes(iconMarker!),
                                                ),
                                              );
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    //icon show color picker
                                    WButtonInkwell(
                                      onPressed: () {
                                        setState(() {
                                          _showListBackground = true;
                                          getIt<EditFeedBloc>().getBackgrounds();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          AppAssets.colorPickerIcon,
                                          width: 28,
                                          height: 28,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              CommonButton(
                                width: 110,
                                color: AppColors.primaryButtonColor,
                                text: 'Post',
                                onTap: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
