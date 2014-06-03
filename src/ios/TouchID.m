#import "HealthKit.h"
#import <Cordova/CDV.h>

@implementation HealthKit

- (void) testMethod:(CDVInvokedUrlCommand*)command {
  NSString *callbackId = command.callbackId;

  CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self writeJavascript:[result toSuccessCallbackString:callbackId]];
}

@end