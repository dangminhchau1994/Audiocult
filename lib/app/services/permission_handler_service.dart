import 'package:audio_cult/app/services/permisssion_service.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/constants/app_colors.dart';

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
          backgroundColor: AppColors.secondaryButtonColor,
          actions: [
            ElevatedButton(
              onPressed: openAppSettings,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primaryButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text(
                context.localize.t_confirm,
                style: context.body2TextStyle()?.copyWith(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primaryButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text(
                context.localize.t_cancel,
                style: context.body2TextStyle()?.copyWith(color: Colors.white),
              ),
            ),
          ],
          title: Text(
            context.localize.t_camera_permission,
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            context.localize.t_camera_permission_requirement,
            style: context.body2TextStyle()?.copyWith(color: AppColors.activeLabelItem),
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

    if (photosPermissionStatus != PermissionStatus.granted 
        && photosPermissionStatus != PermissionStatus.limited) {
      await showDialog(
        context: context,
        builder: (_context) => AlertDialog(
          backgroundColor: AppColors.secondaryButtonColor,
          actions: [
            ElevatedButton(
              onPressed: openAppSettings,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primaryButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text(
                context.localize.t_gallery_permission,
                style: context.body2TextStyle()?.copyWith(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primaryButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text(
                context.localize.t_cancel,
                style: context.body2TextStyle()?.copyWith(color: Colors.white),
              ),
            ),
          ],
          title: Text(
            context.localize.t_gallery_permission,
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            context.localize.t_gallery_permission_requirement,
            style: context.body2TextStyle()?.copyWith(color: AppColors.activeLabelItem),
          ),
        ),
      );
      return false;
    }
    return true;
  }
}
