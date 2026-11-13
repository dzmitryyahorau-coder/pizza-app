import 'package:permission_handler/permission_handler.dart';

enum PermissionResult { granted, denied, permanentlyDenied, restricted }

class PermissionHandler {
  Future<PermissionResult> request(Permission permision) async {
    PermissionStatus status = await permision.status;
    if (status.isDenied) {
      status = await permision.request();
    }

    return _map(status);
  }

  PermissionResult _map(PermissionStatus s) {
    if (s.isGranted || s.isLimited) return PermissionResult.granted;
    if (s.isPermanentlyDenied) return PermissionResult.permanentlyDenied;
    if (s.isRestricted) return PermissionResult.restricted;
    return PermissionResult.denied;
  }
}
