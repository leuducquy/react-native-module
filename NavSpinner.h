//
//  IndicatorModule.h
//  CameraProject
//
//  Created by Quy on 4/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RCTViewManager.h"
#import "QKCSBigLoadingView.h"
@interface NavSpinner : RCTViewManager
@property (nonatomic,strong)QKCSBigLoadingView *indicator;
@end
