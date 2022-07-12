import 'dart:io';
import 'dart:typed_data';
import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_photo_request.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/features/home/post_photos/widgets/add_photo.dart';
import 'package:audio_cult/app/features/home/post_photos/widgets/post_list_image.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/services/media_service.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/list_photos/common_list_multi_photo.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart' hide LatLng;
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../constants/global_constants.dart';
import '../../../utils/bottom_sheet/image_picker_action_sheet.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/file/file_utils.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../../auth/widgets/register_page.dart';
import '../home_bloc.dart';

class PostPhotos extends StatefulWidget {
  const PostPhotos({Key? key}) : super(key: key);

  @override
  State<PostPhotos> createState() => _PostPhotosState();
}

class _PostPhotosState extends State<PostPhotos> with DisposableStateMixin, AutomaticKeepAliveClientMixin {
  SelectMenuModel? _privacy;
  final List<File> _listImages = [];
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());
  final MediaServiceInterface _mediaService = locator<MediaServiceInterface>();
  final UploadPhotoRequest _uploadPhotoRequest = UploadPhotoRequest();
  final Set<Marker> markers = {};
  late GoogleMapController _controller;
  late Uint8List iconMarker;
  bool? _showMap = false;
  bool? _showTagFriends;
  double _lat = 0.0;
  double _lng = 0.0;
  File? file;
  String errorTitle = '';
  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;
  int _page = 0;
  bool _isLoading = false;
  int _sizePerPage = 50;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

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
    _getCustomMarker();
    _privacy = GlobalConstants.listPrivacy[0];
    getIt.get<HomeBloc>().uploadPhotoStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  Future<void> _requestAssets() async {
    // Request permissions.
    final _ps = await PhotoManager.requestPermissionExtend();
    if (!mounted) {
      return;
    }

    // Further requests can be only procceed with authorized or limited.
    if (_ps != PermissionState.authorized && _ps != PermissionState.limited) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(context.l10n.t_camera_permission),
          content: Text(context.l10n.t_need_photos),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(context.l10n.t_cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text(context.l10n.t_settings),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      return;
    }

    // Obtain assets using the path entity.
    final paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
    );
    if (!mounted) {
      return;
    }

    // Return if not paths found.
    if (paths.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('No paths found.');
      return;
    }
    setState(() {
      _path = paths.first;
    });
    _totalEntitiesCount = _path!.assetCount;
    final entities = await _path!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
    });

    if (_ps == PermissionState.limited || _ps == PermissionState.authorized) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonListMultiPhotos(
            entities: _entities,
            path: _path,
            isLoadingMore: _isLoadingMore,
            hasMoreToLoad: _hasMoreToLoad,
            loadMoreAsset: _loadMoreAsset,
            permissionState: _ps,
          ),
        ),
      );
      if (result != null) {
        result.forEach((element) {
          element.file.then((value) async {
            file = value as File;
            _listImages.add(file ?? File(''));
            setState(() {});
          });
        });
      }
    }
  }

  Future<void> _loadMoreAsset() async {
    final entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt<HomeBloc>(),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (_listImages.isEmpty)
                  AddPhoto(
                    onAddPhoto: () {
                      _requestAssets();
                    },
                  )
                else
                  PostListImage(
                    listImages: _listImages,
                    onAddImage: _requestAssets,
                    onRemoveImage: (index) {
                      setState(() {
                        _listImages.removeAt(index);
                      });
                    },
                  ),
                TextField(
                  maxLines: 10,
                  onChanged: (value) {
                    _uploadPhotoRequest.description = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    hintText: context.l10n.t_say_something_photo,
                    hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 10),
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
              child: Row(
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
                          data: GlobalConstants.listPrivacy,
                          onChanged: (value) {
                            setState(() {
                              _privacy = value;
                              _uploadPhotoRequest.privacy = value?.id;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        AppAssets.tagFriends,
                        width: 28,
                        height: 28,
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
                                _uploadPhotoRequest.latLng = '$_lat,$_lng';
                                _uploadPhotoRequest.locationName = placeDetails.fullAddress;
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
                    text: 'Post',
                    onTap: () async {
                      _uploadPhotoRequest.images = _listImages;
                      if (_listImages.length > 10) {
                        await showDialog(
                          context: context,
                          builder: (_context) => AlertDialog(
                            backgroundColor: AppColors.secondaryButtonColor,
                            actions: [
                              CommonButton(
                                width: 100,
                                color: AppColors.primaryButtonColor,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                text: 'Ok',
                              ),
                            ],
                            title: Text(
                              'Warning',
                              style: context.body2TextStyle()?.copyWith(color: AppColors.activeLabelItem),
                            ),
                            content: Text(
                              'the number of images should not exceed the number of 10',
                              style: context.body2TextStyle()?.copyWith(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        getIt<HomeBloc>().uploadPhoto(_uploadPhotoRequest);
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
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
