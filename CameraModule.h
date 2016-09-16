//
//  CameraManager.h
//  AwesomeProject
//
//  Created by Quy on 4/8/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RNImagePickerTarget) {
  RNImagePickerTargetCamera = 1,
  RNImagePickerTargetLibrarySingleImage,
};

@interface CameraModule : NSObject<RCTBridgeModule, UINavigationControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>

@end
