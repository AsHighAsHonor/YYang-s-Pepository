//
//  NSDictionary+Tools.m
//  haneco-ios
//
//  Created by YYang on 6/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "NSDictionary+Tools.h"

@implementation NSDictionary (Tools)
+(BOOL)isEmptyDic:(NSDictionary *)dic andKey:(NSString *)key{
    if([dic objectForKey:key]){
        return NO;
    }
    id obj = [dic objectForKey:key];
    return [obj isEqual:[NSNull null]];
}@end
