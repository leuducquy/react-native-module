//
//  TwiterShareModule.h
//  ignite1
//
//  Created by quy on 7/13/18.
//  Copyright © 2018 Facebook. All rights reserved.
//
@import UIKit;
#import <Foundation/Foundation.h>


#import <React/RCTBridgeModule.h>
@interface RNTwiterShareModule : NSObject <RCTBridgeModule>
-(void)tweet:(NSDictionary *)options
 successCallback:(RCTPromiseResolveBlock)successCallback
failureCallback:(RCTPromiseRejectBlock)failureCallback;
@end
