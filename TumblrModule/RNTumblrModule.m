//
//  RNTumblrModule.m
//  ignite1
//
//  Created by quy on 9/5/18.
//  Copyright © 2018 Facebook. All rights reserved.
//
#import "FlurryTumblr.h"
#import "FlurryTumblrDelegate.h"
#import "RNTumblrModule.h"
#import "TMAPIClient.h"
@interface RNTumblrModule ()

@end

@implementation RNTumblrModule



 RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(
                  tumblrPostImage:(NSString *)urlString)
               
                
{
  
   NSURL *url = [[NSURL alloc] initWithString:urlString];
  FlurryImageShareParameters* imgShareParameters =
  [[FlurryImageShareParameters alloc] init];
  
  imgShareParameters.imageURL = urlString;
 
  [FlurryTumblr setDelegate:self];
  
  dispatch_async(dispatch_get_main_queue(), ^() {
    UIViewController *rootViewController =  [UIApplication sharedApplication].keyWindow.rootViewController;

     [FlurryTumblr post:imgShareParameters presentingViewController:rootViewController];


  });

 
}
- (UIViewController*) topMostController
{
  UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
 
  
  while( topViewController.presentedViewController &&
        topViewController != topViewController.presentedViewController ){
    topViewController = topViewController.presentedViewController;
  }
  
  return topViewController;
}
-(void)flurryTumblrPostSuccess{

  

}
@end
