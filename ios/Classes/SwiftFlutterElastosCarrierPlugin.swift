import Flutter
import UIKit

public class SwiftFlutterElastosCarrierPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_elastos_carrier", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterElastosCarrierPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
