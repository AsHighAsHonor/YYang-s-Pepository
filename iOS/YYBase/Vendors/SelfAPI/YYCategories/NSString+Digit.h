//
//  NSString+Digit.h
//  trader-ios
//
//  Created by YYang1 on 25/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Digit)
+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isPureFloat:(NSString*)string;
@end
