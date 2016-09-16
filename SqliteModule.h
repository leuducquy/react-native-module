//
//  SqliteModule.h
//  CameraProject
//
//  Created by Quy on 4/25/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "RCTBridgeModule.h"
#import <UIKit/UIKit.h>
@interface SqliteModule : NSObject<RCTBridgeModule>
@property (nonatomic, strong) NSString *name;
@property (nonatomic ,strong) NSString *note;
@end
