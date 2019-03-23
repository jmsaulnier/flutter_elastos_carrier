import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_elastos_carrier/flutter_elastos_carrier.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_elastos_carrier');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterElastosCarrier.platformVersion, '42');
  });
}
