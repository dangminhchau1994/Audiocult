import 'dart:io';
import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_photo_request.dart';
import 'package:audio_cult/app/features/home/post_photos/widgets/add_photo.dart';
import 'package:audio_cult/app/features/home/post_photos/widgets/post_list_image.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/services/media_service.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../constants/global_constants.dart';
import '../../../utils/bottom_sheet/image_picker_action_sheet.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../home_bloc.dart';

class PostPhotos extends StatefulWidget {
  const PostPhotos({Key? key}) : super(key: key);

  @override
  State<PostPhotos> createState() => _PostPhotosState();
}

class _PostPhotosState extends State<PostPhotos> with DisposableStateMixin, AutomaticKeepAliveClientMixin {
  SelectMenuModel? _privacy;
  final List<File> _listImages = [];
  final MediaServiceInterface _mediaService = locator<MediaServiceInterface>();
  final UploadPhotoRequest _uploadPhotoRequest = UploadPhotoRequest();

  @override
  void initState() {
    super.initState();
    _privacy = GlobalConstants.listPrivacy[0];
    getIt.get<HomeBloc>().uploadPhotoStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  Future _getImage(AppImageSource _appImageSource) async {
    final _pickedImageFile = await _mediaService.uploadImage(context, AppImageSource.gallery);

    if (_pickedImageFile != null) {
      for (final image in _pickedImageFile) {
        setState(() {
          _listImages.add(image);
        });
      }
    }
  }

  Future<AppImageSource?> _pickImageSource() async {
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
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (_listImages.isEmpty)
                  AddPhoto(
                    onAddPhoto: () {
                      _pickImageSource();
                    },
                  )
                else
                  PostListImage(
                    listImages: _listImages,
                    onAddImage: _pickImageSource,
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
                      SvgPicture.asset(
                        AppAssets.locationIcon,
                        width: 28,
                        height: 28,
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

  @override
  bool get wantKeepAlive => true;
}
