//
//  NSMutableArray+Tools.m
//  haneco-ios
//
//  Created by YYang on 6/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "NSMutableArray+Tools.h"

@implementation NSMutableArray (Tools)
+ (BOOL) isEmptyArray: (NSMutableArray *) list {
    
    if (nil == list) return YES;
    
    if ((NSNull *) list == [NSNull null]) return YES;
    
    if (0 == [list count]) return YES;
    
    return NO;
}
@end
