//
//  NSString+Time.m
//  haneco-ios
//
//  Created by YYang on 4/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)
/**
 *  当前时间戳
 *
 */
+(NSString *)currentTimeString{
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"yyyyMMddHHmmssSSS";
    return [formater stringFromDate:date];
}
@end
