import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_colors.dart';

class ImageUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<CroppedFile?> cropImage(String image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image,
      maxHeight: 1080,
      maxWidth: 1920,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: Platform.isAndroid ? [CropAspectRatioPreset.square] : [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.secondaryButtonColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile;
  }

  static Future<void> onPickGallery({
    BuildContext? context,
    Function(File? image)? onChooseImage,
    Function(String? error)? onError,
  }) async {
    CroppedFile? image;
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1080,
        maxWidth: 1920,
        imageQuality: 100,
      );
      image = await cropImage(pickedFile!.path);
      onChooseImage!(File(image!.path));
    } catch (e) {
      onError!(e.toString());
    }
  }
}
