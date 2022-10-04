import 'dart:io';
import 'dart:typed_data';
import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_video_request.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/home/post_video/widgets/add_video.dart';
import 'package:audio_cult/app/features/home/post_video/widgets/get_video.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:collection/collection.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/responses/profile_data.dart';
import '../../../injections.dart';
import '../../../services/media_service.dart';
import '../../../utils/bottom_sheet/image_picker_action_sheet.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/file/file_utils.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../../auth/widgets/register_page.dart';
import '../post_status/widgets/status_tag_friend_input.dart';

class PostVideo extends StatefulWidget {
  final String? userId;
  const PostVideo({Key? key, this.onAddVideo, this.userId}) : super(key: key);

  final Function()? onAddVideo;

  @override
  State<PostVideo> createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> with DisposableStateMixin, AutomaticKeepAliveClientMixin {
  final MediaServiceInterface _mediaService = locator<MediaServiceInterface>();
  final FocusNode _focusNode = FocusNode();
  final Set<Marker> markers = {};
  final _request = UploadVideoRequest();
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());
  late GoogleMapController _controller;
  late Uint8List iconMarker;
  late bool? _showMap = false;
  late bool? _showTagFriends = false;
  List<ProfileData> _listProfile = [];
  double _lat = 0;
  double _lng = 0;
  File? _video;
  SelectMenuModel? _privacy;
  bool _showAddVideo = true;
  String _urlVideo = '';
  String _locationName = '';
  String _videoTitle = '';
  String _fileName = '';
  String _status = '';
  late List<SelectMenuModel> _privacyMenu;

  void _getCustomMarker() {
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        iconMarker = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _privacyMenu = GlobalConstants.listPrivacy(context);
    _privacy = _privacyMenu.firstWhereOrNull((e) => e.isSelected == true);
    _getCustomMarker();
    _request.userId = widget.userId;
    getIt.get<HomeBloc>().uploadVideoStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  Future _getImage(AppImageSource _appImageSource) async {
    final _pickedVideoFile = await _mediaService.uploadVideo(context, AppImageSource.gallery);

    setState(() {
      _video = _pickedVideoFile;
      _fileName = _video!.path.split('/').last;
      if (_fileName.isNotEmpty) {
        _showAddVideo = false;
      }
    });
  }

  Future<AppImageSource?> _pickVideoSource() async {
    final _appImageSource = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => const ImagePickerActionSheet(),
    );
    if (_appImageSource != null) {
      await _getImage(_appImageSource as AppImageSource);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt<HomeBloc>(),
      child: Provider<UploadSongBloc>(
        create: (context) => UploadSongBloc(locator.get(), locator.get()),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if (_showAddVideo || _fileName.isEmpty)
                    Visibility(
                      visible: _showAddVideo,
                      child: AddVideo(
                        onAddVideo: _pickVideoSource,
                      ),
                    )
                  else
                    GetVideo(
                      onRemoveFile: () {
                        setState(() {
                          _showAddVideo = true;
                          _fileName = '';
                        });
                      },
                      videoName: _fileName,
                    ),
                  CommonInput(
                    focusNode: _focusNode,
                    onChanged: (value) {
                      if (_fileName.isEmpty) {
                        setState(() {
                          _urlVideo = value;
                        });
                      } else {
                        _videoTitle = value;
                      }
                    },
                    hintText: _fileName.isEmpty ? context.localize.t_paste_url : context.localize.t_video_title,
                    suffixIcon: _showAddVideo || _urlVideo.isEmpty || _fileName.isNotEmpty
                        ? const SizedBox()
                        : WButtonInkwell(
                            onPressed: () {
                              setState(() {
                                _showAddVideo = true;
                                _focusNode.unfocus();
                              });
                            },
                            child: Text(
                              context.localize.t_cancel,
                              style: context.buttonTextStyle()!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.activeLabelItem,
                                  ),
                            ),
                          ),
                    onTap: () {
                      setState(() {
                        _showAddVideo = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: !_showAddVideo,
                    child: TextField(
                      maxLines: 10,
                      onChanged: (value) {
                        setState(() {
                          _status = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          bottom: 10,
                        ),
                        hintText: context.localize.t_say_something_video,
                        hintStyle:
                            context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _showMap!,
                    child: _buildMap(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
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
                  children: [
                    Visibility(
                      visible: _showTagFriends!,
                      child: StatusTagFriendInput(
                        onChooseTags: (value) {
                          final sb = StringBuffer();
                          for (final item in value) {
                            sb.write('${item.userId},');
                          }
                          _request.taggedFriends = sb.toString();
                        },
                        onDeleteTag: (value) {
                          final sb = StringBuffer();
                          for (final item in _listProfile) {
                            sb.write('${item.userId},');
                          }
                          _request.taggedFriends = sb.toString();
                          _listProfile.remove(value);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: CommonDropdown(
                                selection: _privacy,
                                hint: '',
                                backgroundColor: Colors.transparent,
                                noBorder: true,
                                data: _privacyMenu,
                                onChanged: (value) {
                                  setState(() {
                                    _privacy = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
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
                              child: SvgPicture.asset(
                                AppAssets.tagFriends,
                                width: 28,
                                height: 28,
                              ),
                            ),
                            const SizedBox(width: 20),
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
                                      _locationName = placeDetails.fullAddress ?? '';
                                      _showMap = true;
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
                          ],
                        ),
                        CommonButton(
                          width: 110,
                          color: AppColors.primaryButtonColor,
                          text: context.localize.t_post,
                          onTap: () async {
                            _request.video = _video;
                            _request.title = _videoTitle;
                            _request.url = _urlVideo;
                            _request.latLng = '$_lat,$_lng';
                            _request.locationName = _locationName;
                            _request.privacy = _privacy?.id;
                            _request.statusInfo = _status;

                            getIt<HomeBloc>().uploadVideo(_request);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
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
              target: LatLng(
                _lat,
                _lng,
              ),
              zoom: 10,
            ),
            markers: markers,
            onMapCreated: (controller) {
              _controller = controller;
              FileUtils.getJsonFile(AppAssets.nightMapJson).then((value) {
                _controller.setMapStyle(value);
              });
            },
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: WButtonInkwell(
            onPressed: () {
              setState(() {
                _showMap = false;
              });
            },
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

  @override
  bool get wantKeepAlive => true;
}
