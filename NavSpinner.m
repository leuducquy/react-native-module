//
//  IndicatorModule.m
//  CameraProject
//
//  Created by Quy on 4/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "NavSpinner.h"

@implementation NavSpinner

RCT_EXPORT_MODULE();
- (UIView *)view
{

    return   [[QKCSBigLoadingView alloc] initHUDView];;
}
RCT_CUSTOM_VIEW_PROPERTY(isAnimating,BOOL,QKCSBigLoadingView){
  
  if ([view respondsToSelector:@selector(setIsAnimating:)]) {
    view.isAnimating = json ? [RCTConvert BOOL:json]:defaultView.isAnimating;
  }
}

@end
