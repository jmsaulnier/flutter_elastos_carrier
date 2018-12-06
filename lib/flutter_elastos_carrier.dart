import 'dart:async';

import 'package:flutter/services.dart';

class FlutterElastosCarrier {
  static const MethodChannel _channel =
      const MethodChannel('flutter_elastos_carrier');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
