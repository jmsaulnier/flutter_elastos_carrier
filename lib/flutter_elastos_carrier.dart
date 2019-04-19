import 'dart:async';

import 'package:flutter/services.dart' show MethodChannel;

class FlutterElastosCarrier {
  static const MethodChannel _channel =
      const MethodChannel('flutter_elastos_carrier');

  static Future<void> initializeSharedInstance() async {
    return await _channel.invokeMethod('initializeSharedInstance');
  }

  static Future<void> start() async {
    return await _channel.invokeMethod('start');
  }

  static Future<void> kill() async {
    return await _channel.invokeMethod('kill');
  }

  static Future<String> get version async {
    return await _channel.invokeMethod('getVersion');
  }

  static Future<String> get address async {
    return await _channel.invokeMethod('getAddress');
  }

  static Future<String> get nodeId async {
    return await _channel.invokeMethod('getNodeId');
  }

  static Future<String> get userId async {
    return await _channel.invokeMethod('getUserId');
  }
}
