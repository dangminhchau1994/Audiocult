import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<PermissionStatus> checkPermission(Future<PermissionStatus> permissionStatus) async {
    final status = await permissionStatus;
    if (status == PermissionStatus.granted) {
      return PermissionStatus.granted;
    } else if (status == PermissionStatus.denied) {
      return PermissionStatus.denied;
    } else {
      return PermissionStatus.permanentlyDenied;
    }
  }
}
