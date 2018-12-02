//
//  TumblViewController.h
//  ignite1
//
//  Created by quy on 9/5/18.
//  Copyright © 2018 Facebook. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <TMTumblrSDK/TMAPIClient.h>
#import <TMTumblrSDK/TMOAuthAuthenticator.h>
@interface TumblViewController : UIViewController
- (instancetype)initWithSession:(TMURLSession *)session authenticator:(TMOAuthAuthenticator *)authenticator;
@end
