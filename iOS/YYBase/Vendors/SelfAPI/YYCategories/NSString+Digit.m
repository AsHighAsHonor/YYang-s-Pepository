//
//  NSString+Digit.m
//  trader-ios
//
//  Created by YYang1 on 25/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "NSString+Digit.h"

@implementation NSString (Digit)

+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}



+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end
