//
//  I18nLocale.m
//  HoatdongMobile
//
//  Created by Quy on 4/14/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "I18nLocale.h"

@implementation I18nLocale
RCT_EXPORT_MODULE();
/*
 * Private implementation
 */
-(NSString*) getCurrentLocale{
  NSString *localeString=[[NSLocale currentLocale] localeIdentifier];
  NSArray* arrayString = [localeString componentsSeparatedByString: @"_"];
  return [arrayString objectAtIndex:0];
  
}

- (NSDictionary *)constantsToExport
{
  return @{ @"locale": [self getCurrentLocale] };
}
@end
