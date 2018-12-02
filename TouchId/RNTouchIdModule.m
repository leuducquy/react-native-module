//
//  RNTouchIdModule.m
//  ignite1
//
//  Created by quy on 6/22/18.
//  Copyright © 2018 Facebook. All rights reserved.
//



#import <React/RCTUtils.h>


#import <LocalAuthentication/LocalAuthentication.h>
#import "RNTouchIdModule.h"
@interface RNTouchIdModule () {
  LAContext *context;
}

@end
@implementation RNTouchIdModule

  RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(removeContext){
  if(context != nil){
    [context invalidate];
    context = nil;
  }
}
  RCT_EXPORT_METHOD(isSupported: (RCTResponseSenderBlock)callback)
  {
    
    if (![self supportsPasscodeAuth]) {
      callback(@[RCTMakeError(@"PasscodeAuthNotSupported", nil, nil)]);
      return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    // Check if PasscodeAuth Authentication is available
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil]) {
      callback(@[[NSNull null], @true]);
      // PasscodeAuth is not set
    } else {
      callback(@[RCTMakeError(@"TouchIdNotSet", nil, nil)]);
      return;
    }
    
  }
  
  RCT_EXPORT_METHOD(authenticate: (NSString *)reason
                    callback: (RCTResponseSenderBlock)callback)
  {
   
    if (![self supportsPasscodeAuth]) {
      callback(@[RCTMakeError(@"TouchIdNotSupported", nil, nil)]);
      return;
    }
    
   context = [[LAContext alloc] init];
    NSError *error;
    
    // Device has PasscodeAuth
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
      // Attempt Authentication
      __block LAContext *newContext = context;
      [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
              localizedReason:reason
                        reply:^(BOOL success, NSError *error)
       {
         // Failed Authentication
         if (error) {
           NSString *errorReason;
           
           switch (error.code) {
             case LAErrorAuthenticationFailed:
             errorReason = @"LAErrorAuthenticationFailed";
             break;
             
             case LAErrorUserCancel:
             errorReason = @"LAErrorUserCancel";
             break;
             
             case LAErrorUserFallback:
             errorReason = @"LAErrorUserFallback";
             break;
             
             case LAErrorSystemCancel:
             errorReason = @"LAErrorSystemCancel";
               [newContext invalidate];
               newContext = nil;
             break;
             
             case LAErrorPasscodeNotSet:
             errorReason = @"LAErrorPasscodeNotSet";
             break;
             
             default:
             errorReason = @"PasscodeAuthUnknownError";
             break;
           }
          
           NSLog(@"Authentication failed: %@", errorReason);
           callback(@[RCTMakeError(errorReason, nil, nil)]);
             [self detroyContext];
           return;
         }
         [self detroyContext];
         // Authenticated Successfully
         callback(@[[NSNull null], @"Authenticated with TouchId."]);
       }];
      
      // Device does not support PasscodeAuth
    } else {
      callback(@[RCTMakeError(@"TouchIdNotSet", nil, nil)]);
      [self detroyContext];
      return;
    }
  }
-(void)detroyContext  {
  if(context != nil){
    [context invalidate];
    context = nil;
  }
}
- (BOOL)supportsPasscodeAuth {
  // TouchId is only available in iOS 9.  In iOS8, `LAPolicyDeviceOwnerAuthentication` is present but not implemented.
  float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
  
  return osVersion >= 9.0;
}
@end
