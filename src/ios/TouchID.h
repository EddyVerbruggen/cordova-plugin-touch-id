#import <Cordova/CDVPlugin.h>

@interface TouchID :CDVPlugin

- (void) isAvailable:(CDVInvokedUrlCommand*)command;

- (void) verifyFingerprint:(CDVInvokedUrlCommand*)command;

@end
