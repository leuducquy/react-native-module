//
//  TwiterShareModule.m
//  ignite1
//
//  Created by quy on 7/13/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNTwiterShareModule.h"

@import TwitterKit;
#import <React/RCTConvert.h>
#import <Social/Social.h>

@implementation RNTwiterShareModule
{
  bool hasListeners;

}

  // Expose this module to the React Native bridge
  RCT_EXPORT_MODULE()


  RCT_EXPORT_METHOD(tweet:(NSDictionary *)options
                  successCallback:(RCTPromiseResolveBlock)successCallback
                   failureCallback:(RCTPromiseRejectBlock)failureCallback)
  {
    

    TWTRComposer *composer = [[TWTRComposer alloc] init];
    NSString *urlString = [RCTConvert NSString:options[@"url"]];
    NSString *title = [RCTConvert NSString:options[@"title"]];
    [composer setText:[NSString stringWithFormat:@"%@", title]];
    NSURL *aURL = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSData *data = [NSData dataWithContentsOfURL:aURL];
    [composer setImage:[UIImage imageWithData:data]];
    
    dispatch_async(dispatch_get_main_queue(), ^() {
      [composer showFromViewController:[UIApplication sharedApplication].keyWindow.rootViewController completion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
          failureCallback(@"Tweet composition cancelled", @"Tweet composition cancelled",nil);
       
        }
        else {
          successCallback(@[@"Tweet success!"]);
        }
      }];
    });
   
   
   
  }
  
  @end
