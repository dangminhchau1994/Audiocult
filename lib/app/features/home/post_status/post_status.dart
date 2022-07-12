import 'dart:convert';
import 'dart:typed_data';

import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/requests/create_post_request.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/home/post_status/widgets/status_background.dart';
import 'package:audio_cult/app/features/home/post_status/widgets/status_input.dart';
import 'package:audio_cult/app/features/home/post_status/widgets/status_list_background.dart';
import 'package:audio_cult/app/features/home/post_status/widgets/status_map.dart';
import 'package:audio_cult/app/features/home/post_status/widgets/status_tag_friend_input.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/file/file_utils.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../../auth/widgets/register_page.dart';

class PostStatus extends StatefulWidget {
  const PostStatus({Key? key}) : super(key: key);

  @override
  State<PostStatus> createState() => _PostStatusState();
}

class _PostStatusState extends State<PostStatus> with DisposableStateMixin, AutomaticKeepAliveClientMixin {
  final CreatePostRequest _createPostRequest = CreatePostRequest();
  final TextEditingController _textEditingController = TextEditingController(text: '');
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());
  final Set<Marker> markers = {};
  late Uint8List iconMarker;
  GoogleMapController? _controller;
  double _lat = 0.0;
  double _lng = 0.0;
  SelectMenuModel? _privacy;
  bool? _showMap = false;
  bool? _showListBackground;
  bool? _enableBackground;
  bool? _showTagFriends;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _privacy = GlobalConstants.listPrivacy[0];
    _imagePath = '';
    _showListBackground = false;
    _showTagFriends = false;
    _enableBackground = false;
    _getCustomMarker();
    getIt.get<HomeBloc>().createPostStream.listen((data) {
      //Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
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
    return BlocHandle(
      bloc: getIt.get<HomeBloc>(),
      child: Provider<UploadSongBloc>(
        create: (context) => UploadSongBloc(locator.get(), locator.get()),
        child: Stack(
          children: [
            if (_enableBackground!)
              StatusBackground(
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
              StatusInput(
                textEditingController: _textEditingController,
                isAlignCenter: false,
                maxLine: 10,
                onChanged: (value) {
                  _createPostRequest.userStatus = value;
                },
              ),
            Visibility(
              visible: _showMap!,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusInput(
                      textEditingController: _textEditingController,
                      isAlignCenter: false,
                      maxLine: 3,
                      onChanged: (value) {
                        _createPostRequest.userStatus = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    StatusMap(
                      lat: _lat,
                      lng: _lng,
                      markers: markers,
                      controller: _controller,
                      showMap: () {
                        setState(() {
                          _showMap = false;
                        });
                      },
                    )
                  ],
                ),
              ),
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
                        Visibility(
                          visible: _showTagFriends!,
                          child: StatusTagFriendInput(
                            onChooseTags: (value) {
                              final sb = StringBuffer();
                              for (final item in value) {
                                sb.write('${item.userId},');
                              }
                              _createPostRequest.taggedFriends = sb.toString();
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_showListBackground!)
                              StatusListBackground(
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
                                  WButtonInkwell(
                                    onPressed: () async {
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
                                            markers.add(
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        AppAssets.locationIcon,
                                        width: 28,
                                        height: 28,
                                      ),
                                    ),
                                  ),
                                  WButtonInkwell(
                                    onPressed: () {
                                      setState(() {
                                        _showListBackground = true;
                                        getIt<HomeBloc>().getBackgrounds();
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
                                  ),
                                ],
                              ),
                            CommonButton(
                              width: 110,
                              color: AppColors.primaryButtonColor,
                              text: 'Post',
                              onTap: () {
                                getIt.get<HomeBloc>().postStatus(_createPostRequest);
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
