import 'dart:io';
import 'dart:math';

import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/services/media_service.dart';
import 'package:audio_cult/app/services/permisssion_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MediaServiceHandler implements MediaServiceInterface {
  @override
  PermissionService get permissionService => locator<PermissionService>();

  Future<bool> _handleImageUploadPermissions(BuildContext context, AppImageSource? _imageSource) async {
    if (_imageSource == null) {
      return false;
    }
    if (_imageSource == AppImageSource.camera) {
      return permissionService.handleCameraPermission(context);
    } else if (_imageSource == AppImageSource.gallery) {
      return permissionService.handlePhotosPermission(context);
    } else {
      return false;
    }
  }

  @override
  Future<List<File>?> uploadImage(
    BuildContext context,
    AppImageSource appImageSource, {
    bool shouldCompress = true,
  }) async {
    // Handle permissions according to image source,
    final canProceed = await _handleImageUploadPermissions(context, appImageSource);

    if (canProceed) {
      final processedPickedImageFile = <File>[];

      // Convert our own AppImageSource into a format readable by the used package
      // In this case it's an ImageSource enum
      ImageSource? _imageSource = ImageSource.values.byName(appImageSource.name);

      final imagePicker = ImagePicker();

      final rawPickedImageFile = await imagePicker.pickMultiImage();

      if (rawPickedImageFile != null) {
        //to convert from XFile type provided by the package to dart:io's File type

        for (final element in rawPickedImageFile) {
          processedPickedImageFile.add(File(element.path));
        }
      }
      return processedPickedImageFile;
    }
    return null;
  }

  @override
  Future<File?> uploadVideo(
    BuildContext context,
    AppImageSource appImageSource, {
    bool shouldCompress = true,
  }) async {
    // Handle permissions according to image source,
    final canProceed = await _handleImageUploadPermissions(context, appImageSource);

    if (canProceed) {
      var processedPickedImageFile = File('');

      // Convert our own AppImageSource into a format readable by the used package
      // In this case it's an ImageSource enum
      ImageSource? _imageSource = ImageSource.values.byName(appImageSource.name);

      final imagePicker = ImagePicker();

      final rawPickedImageFile = await imagePicker.pickVideo(source: _imageSource);

      // ignore: join_return_with_assignment
      processedPickedImageFile = File(rawPickedImageFile?.path ?? '');

      return processedPickedImageFile;
    }

    return null;
  }

  @override
  Future<File?> compressFile(File file, {int quality = 30}) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/${Random().nextInt(1000)}-temp.jpg';

    return FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
    );
  }
}
