//
//  NSMutableDictionary+Tools.m
//  haneco-ios
//
//  Created by YYang on 6/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "NSMutableDictionary+Tools.h"

@implementation NSMutableDictionary (Tools)
+(BOOL)isEmptyDic:(NSDictionary *)dic andKey:(NSString *)key
{
    if([dic objectForKey:key])
    {
        id obj = [dic objectForKey:key];
        if([obj isEqual:[NSNull null]]){
            return YES;
        }else{
            return NO;
        }
    }else{
        return  YES;
    }
    
}
@end
