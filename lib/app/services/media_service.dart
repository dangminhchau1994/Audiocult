import 'dart:io';

import 'package:audio_cult/app/services/permisssion_service.dart';
import 'package:flutter/material.dart';

enum AppImageSource {
  camera,
  gallery,
  video,
}

abstract class MediaServiceInterface {
  PermissionService get permissionService;

  Future<List<File>?> uploadImage(
    BuildContext context,
    AppImageSource appImageSource, {
    bool shouldCompress = true,
  });

  Future<File?> uploadVideo(
    BuildContext context,
    AppImageSource appImageSource, {
    bool shouldCompress = true,
  });

  Future<File?> compressFile(File file, {int quality = 30});
}
