import 'package:audio_cult/app/services/permisssion_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerPermissionService implements PermissionService {
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return Permission.photos.request();
  }

  @override
  Future<bool> handleCameraPermission(BuildContext context) async {
    final cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: context,
        builder: (_context) => AlertDialog(
          actions: [
            const ElevatedButton(
              onPressed: openAppSettings,
              child: Text('Confirm'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
          title: const Text('Camera Permission'),
          content: const Text(
            'Camera permission should Be granted to use this feature, would you like to go to app settings to give camera permission?',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    final photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: context,
        builder: (_context) => AlertDialog(
          actions: [
            const ElevatedButton(
              onPressed: openAppSettings,
              child: Text('Photos Permission'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
          title: const Text('Camera Permission'),
          content: const Text(
            'Photos permission should Be granted to use this feature, would you like to go to app settings to give photos permission?',
          ),
        ),
      );
      return false;
    }
    return true;
  }
}
