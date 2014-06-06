#import "TouchID.h"
// at the moment this import only works on a real device, not the simulator!
#import <LocalAuthentication/LocalAuthentication.h>

@implementation TouchID

- (void) verifyFingerprint:(CDVInvokedUrlCommand*)command {

    NSString *message = [command.arguments objectAtIndex:0];
    NSString *callbackId = command.callbackId;
    
    if (NSClassFromString(@"LAContext") == NULL) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR]
                                    callbackId:callbackId];
        return;
    }

    NSError *error = nil;
    LAContext *laContext = [[LAContext alloc] init];
    
    if (![laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]]
                                    callbackId:callbackId];
        return;
    }
    
    [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message reply:^(BOOL authOK, NSError *error) {
        if (authOK) {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                        callbackId:command.callbackId];
        } else {
            // invoked when the scan failed 3 times in a row, the cancel button was pressed, or the 'enter password' button was pressed
            NSArray *errorKeys = @[@"code", @"localizedDescription"];
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:[error dictionaryWithValuesForKeys:errorKeys]]
                                        callbackId:callbackId];
        }
    }];
}

- (void) isAvailable:(CDVInvokedUrlCommand*)command; {
    
    if (NSClassFromString(@"LAContext") == NULL) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
        return;
    }

    NSError *error = nil;
    LAContext *laContext = [[LAContext alloc] init];
    
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK]
                                    callbackId:command.callbackId];
    } else {
        NSArray *errorKeys = @[@"code", @"localizedDescription"];
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:[error dictionaryWithValuesForKeys:errorKeys]]
                                    callbackId:command.callbackId];
    }
}

@end