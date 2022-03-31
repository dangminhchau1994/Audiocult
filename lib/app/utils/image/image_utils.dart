import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_colors.dart';

class ImageUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> _cropImage(String image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image,
      maxHeight: 1000,
      maxWidth: 1000,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: Platform.isAndroid ? [CropAspectRatioPreset.square] : [CropAspectRatioPreset.square],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: AppColors.secondaryButtonColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Cropper',
      ),
    );
    return croppedFile;
  }

  static Future<void> onPickGallery({
    BuildContext? context,
    Function(File? image)? onChooseImage,
    Function(String? error)? onError,
  }) async {
    File? image;
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 1000,
        imageQuality: 100,
      );
      image = await _cropImage(pickedFile!.path);
      onChooseImage!(image);
    } catch (e) {
      onError!(e.toString());
    }
  }
}
