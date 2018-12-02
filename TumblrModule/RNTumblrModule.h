//
//  RNTumblrModule.h
//  ignite1
//
//  Created by quy on 9/5/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <React/RCTBridgeModule.h>
@interface RNTumblrModule : NSObject <RCTBridgeModule>
-(void)tumblrPostImage:(NSString *)urlString;
@end
