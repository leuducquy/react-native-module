//
//  RNSafariModule.h
//  ignite1
//
//  Created by quy on 8/2/18.
//  Copyright © 2018 Facebook. All rights reserved.
//
#import <React/RCTEventEmitter.h>
#import <Foundation/Foundation.h>
@import SafariServices;
#import <React/RCTBridgeModule.h>
@interface RNSafariModule :  RCTEventEmitter <RCTBridgeModule,SFSafariViewControllerDelegate>

@end
