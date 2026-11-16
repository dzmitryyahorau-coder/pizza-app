import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionResult { granted, denied, permanentlyDenied, restricted }

class PermissionHandler {
  Future<PermissionResult> request(Permission permission) {
    if (permission == Permission.location ||
        permission == Permission.locationWhenInUse) {
      return _requestViaGeolocator();
    }
    return _requestViaPermissionHandler(permission);
  }

  Future<PermissionResult> _requestViaPermissionHandler(
    Permission permission,
  ) async {
    PermissionStatus status = await permission.status;
    if (status.isDenied) {
      status = await permission.request();
    }
    return _map(status);
  }

  Future<PermissionResult> _requestViaGeolocator() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return switch (permission) {
      LocationPermission.whileInUse ||
      LocationPermission.always => PermissionResult.granted,
      LocationPermission.deniedForever => PermissionResult.permanentlyDenied,
      _ => PermissionResult.denied,
    };
  }

  PermissionResult _map(PermissionStatus s) {
    if (s.isGranted || s.isLimited) return PermissionResult.granted;
    if (s.isPermanentlyDenied) return PermissionResult.permanentlyDenied;
    if (s.isRestricted) return PermissionResult.restricted;
    return PermissionResult.denied;
  }
}
