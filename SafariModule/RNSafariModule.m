//
//  RNSafariModule.m
//  ignite1
//
//  Created by quy on 8/2/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNSafariModule.h"
#import <React/RCTConvert.h>

@implementation RNSafariModule
{
  bool hasListeners;
  SFSafariViewController *_safariView;
}
RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

- (void)startObserving
{
  hasListeners = YES;
}

- (void)stopObserving
{
  hasListeners = NO;
}
RCT_EXPORT_METHOD(openUrl:(NSString *)urlString)
{
  
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  
  _safariView = [[SFSafariViewController alloc] initWithURL:url];
  _safariView.delegate = self;
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_safariView];
  
    _safariView.preferredBarTintColor = [UIColor colorWithRed:(75/255.0) green:(82/255.0) blue:(109/255.0) alpha:1.0];
  
  [navigationController setNavigationBarHidden:YES animated:NO];
  dispatch_async(dispatch_get_main_queue(), ^{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:navigationController animated:YES completion:nil];
  });
  if (hasListeners) {
    [self sendEventWithName:@"SafariViewOnShow" body:nil];
  }
}
RCT_EXPORT_METHOD(dismiss)
{
  [_safariView dismissViewControllerAnimated:true completion:nil];
}
- (NSArray<NSString *> *)supportedEvents
{
  return @[@"SafariViewOnShow", @"SafariViewOnDismiss"];
}
#pragma SFSafariViewControllerDelegate
-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
  // Done button pressed
  
  _safariView = nil;
  NSLog(@"[SafariView] SafariView dismissed.");
  if (hasListeners) {
    [self sendEventWithName:@"SafariViewOnDismiss" body:nil];
  }
 
}
@end
