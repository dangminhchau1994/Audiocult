import 'dart:io';
import 'package:audio_cult/app/features/home/post_photos/widgets/add_photo.dart';
import 'package:audio_cult/app/features/home/post_photos/widgets/post_list_image.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/services/media_service.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../constants/global_constants.dart';
import '../../../utils/bottom_sheet/image_picker_action_sheet.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';

class PostPhotos extends StatefulWidget {
  const PostPhotos({Key? key}) : super(key: key);

  @override
  State<PostPhotos> createState() => _PostPhotosState();
}

class _PostPhotosState extends State<PostPhotos> {
  SelectMenuModel? _privacy;
  final MediaServiceInterface _mediaService = locator<MediaServiceInterface>();
  List<File> _listImages = [];

  @override
  void initState() {
    super.initState();
    _privacy = GlobalConstants.listPrivacy[0];
  }

  Future _getImage(AppImageSource _appImageSource) async {
    final _pickedImageFile = await _mediaService.uploadImage(context, AppImageSource.gallery);

    if (_pickedImageFile != null) {
      for (final image in _pickedImageFile) {
        setState(() {
          _listImages.add(image);
          debugPrint('leuleu: ${_listImages.length}');
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
    return Stack(
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
                ),
              TextField(
                maxLines: 10,
                onChanged: (value) {},
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
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
                  onTap: () {},
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
