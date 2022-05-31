import 'dart:typed_data';

import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/requests/create_post_request.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/home/widgets/background_item.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:audio_cult/w_components/textfields/common_chip_input.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../data_source/models/responses/background/background_response.dart';
import '../../../data_source/models/responses/profile_data.dart';
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
  late GoogleMapController _controller;
  late Uint8List iconMarker;
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
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
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
              _buildBackground(_imagePath ?? '')
            else if (_showMap!)
              const SizedBox()
            else
              TextField(
                maxLines: 10,
                controller: _textEditingController,
                onChanged: (value) {
                  _createPostRequest.userStatus = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  hintText: context.l10n.t_what_new,
                  hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            Visibility(
              visible: _showMap!,
              child: _buildMap(),
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
                          child: _buildTagFriendInput(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_showListBackground!)
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    WButtonInkwell(
                                      onPressed: () {
                                        setState(() {
                                          _showListBackground = false;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.secondaryButtonColor,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 20,
                                          color: AppColors.subTitleColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    StreamBuilder<BlocState<List<BackgroundResponse>>>(
                                      initialData: const BlocState.loading(),
                                      stream: getIt<HomeBloc>().getBackgroundStream,
                                      builder: (context, snapshot) {
                                        final state = snapshot.data!;

                                        return state.when(
                                          success: (success) {
                                            final data = success as List<BackgroundResponse>;

                                            return SizedBox(
                                              height: 50,
                                              width: 240,
                                              child: ListView.separated(
                                                separatorBuilder: (context, index) => const SizedBox(width: 10),
                                                itemCount: data[0].backgroundsList?.length ?? 0,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) => BackgroundItem(
                                                  data: data[0].backgroundsList?[index],
                                                  onItemClick: (data) {
                                                    setState(() {
                                                      _createPostRequest.statusBackgroundId = data.backgroundId;
                                                      _imagePath = data.imageUrl ?? '';
                                                      _enableBackground = true;
                                                      _showMap = false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          loading: () {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primaryButtonColor,
                                              ),
                                            );
                                          },
                                          error: (error) {
                                            return ErrorSectionWidget(
                                              errorMessage: error,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
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

  Widget _buildMap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) {},
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(18),
            hintText: context.l10n.t_what_new,
            hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
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
        )
      ],
    );
  }

  Widget _buildTagFriendInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.secondaryButtonColor),
      child: Row(
        children: [
          Text(
            'with: ',
            style: context.bodyTextStyle()?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: CommonChipInput(
              hintText: context.l10n.t_who_with_you,
              maxChip: 10,
              enableBorder: false,
              isFillColor: false,
              chooseMany: true,
              onChooseMultipleTag: (value) {},
              onDeleteTag: (value) {},
              onPressedChip: (ProfileData value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(String imagePath) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CommonImageNetWork(
          imagePath: imagePath,
          width: double.infinity,
          height: 290,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _textEditingController,
            maxLines: 3,
            textAlign: TextAlign.center,
            onChanged: (value) {
              _createPostRequest.userStatus = value;
            },
            decoration: InputDecoration(
              hintText: context.l10n.t_what_new,
              hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _enableBackground = false;
                _createPostRequest.statusBackgroundId = '0';
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.close,
                size: 25,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
