import Flutter
import Foundation
import AVFoundation
import UIKit
import ElastosCarrierSDK

public class SwiftFlutterElastosCarrierPlugin: NSObject, FlutterPlugin {
    
    fileprivate static let checkURL = "https://apache.org"

    @objc(carrierInstance)
    var carrierInstance: ElastosCarrierSDK.Carrier!

    fileprivate var networkManager : NetworkReachabilityManager?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_elastos_carrier", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterElastosCarrierPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    @objc(handleMethodCall:result:) public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        if call.method == "start" {
            self.start(call, result: result)
        }else if call.method == "kill" {
            self.kill(call, result: result)
        }else if call.method == "getVersion" {
            self.getVersion(call, result: result)
        }else if call.method == "getAddress" {
            self.getAddress(call, result: result)
        }else if call.method == "getNodeId" {
            self.getNodeId(call, result: result)
        }else if call.method == "getUserId" {
             self.getUserId(call, result: result)
        }
        
    }

    public func initializeSharedInstance() {

        if carrierInstance == nil {
            do {
                if networkManager == nil {
                    let url = URL(string: SwiftFlutterElastosCarrierPlugin.checkURL)
                    networkManager = NetworkReachabilityManager(host: url!.host!)
                }
                
                guard networkManager!.isReachable else {
                    print("network is not reachable")
                    networkManager?.listener = { [weak self] newStatus in
                        if newStatus == .reachable(.ethernetOrWiFi) || newStatus == .reachable(.wwan) {
                            self?.initializeSharedInstance()
                        }
                    }
                    networkManager?.startListening()
                    return
                }
                
                let carrierDirectory: String = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/carrier"
                if !FileManager.default.fileExists(atPath: carrierDirectory) {
                    var url = URL(fileURLWithPath: carrierDirectory)
                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                    
                    var resourceValues = URLResourceValues()
                    resourceValues.isExcludedFromBackup = true
                    try url.setResourceValues(resourceValues)
                }
                
                let options = CarrierOptions()
                options.bootstrapNodes = [BootstrapNode]()
                
                let bootstrapNode = BootstrapNode()
                bootstrapNode.ipv4 = "13.58.208.50"
                bootstrapNode.port = "33445"
                bootstrapNode.publicKey = "89vny8MrKdDKs7Uta9RdVmspPjnRMdwMmaiEW27pZ7gh"
                options.bootstrapNodes?.append(bootstrapNode)
                
                bootstrapNode.ipv4 = "18.216.102.47"
                bootstrapNode.port = "33445"
                bootstrapNode.publicKey = "G5z8MqiNDFTadFUPfMdYsYtkUDbX5mNCMVHMZtsCnFeb"
                options.bootstrapNodes?.append(bootstrapNode)
                
                bootstrapNode.ipv4 = "18.216.6.197"
                bootstrapNode.port = "33445"
                bootstrapNode.publicKey = "H8sqhRrQuJZ6iLtP2wanxt4LzdNrN2NNFnpPdq1uJ9n2"
                options.bootstrapNodes?.append(bootstrapNode)
                
                bootstrapNode.ipv4 = "54.223.36.193"
                bootstrapNode.port = "33445"
                bootstrapNode.publicKey = "5tuHgK1Q4CYf4K5PutsEPK5E3Z7cbtEBdx7LwmdzqXHL"
                options.bootstrapNodes?.append(bootstrapNode)
                
                bootstrapNode.ipv4 = "52.83.191.228"
                bootstrapNode.port = "33445"
                bootstrapNode.publicKey = "3khtxZo89SBScAMaHhTvD68pPHiKxgZT6hTCSZZVgNEm"
                options.bootstrapNodes?.append(bootstrapNode)
                
                options.udpEnabled = true
                options.persistentLocation = carrierDirectory
                
                try Carrier.initializeSharedInstance(options: options, delegate: self)
                print("carrier instance created")
                
                networkManager = nil
                carrierInstance = Carrier.sharedInstance()
                
                try! carrierInstance.start(iterateInterval: 1000)
                print("carrier started, waiting for ready")
            }
            catch {
                NSLog("Start carrier instance error : \(error.localizedDescription)")
            }
        }

    }

    public func start(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.initializeSharedInstance();
        result(true);
    }

    public func kill(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        carrierInstance.kill();
        result(true);
    }

    public func getVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(Carrier.getVersion());
    }

    public func getAddress(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(carrierInstance.getAddress());
    }

    public func getNodeId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(carrierInstance.getNodeId());
    }

    public func getUserId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(carrierInstance.getUserId());
    }
}

// MARK: - CarrierDelegate
extension SwiftFlutterElastosCarrierPlugin : CarrierDelegate
{
    
}
