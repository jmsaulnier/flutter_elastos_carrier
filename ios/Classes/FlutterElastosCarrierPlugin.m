#import "FlutterElastosCarrierPlugin.h"
#import <flutter_elastos_carrier/flutter_elastos_carrier-Swift.h>

@implementation FlutterElastosCarrierPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterElastosCarrierPlugin registerWithRegistrar:registrar];
}
@end
