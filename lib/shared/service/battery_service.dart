import 'package:flutter/services.dart';

class BatteryService {
  static const _channel = MethodChannel('pizza_app/battery');

  bool promptShown = false;

  Future<int?> getBatteryLevel() async {
    try {
      final level = await _channel.invokeMethod<int>('getBatteryLevel');

      return (level == null || level < 0) ? null : level;
    } on PlatformException catch (e) {
      return null;
    } on MissingPluginException {
      return null;
    }
  }
}
