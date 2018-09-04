//
//  NSBundle+Load.m
//  haneco-ios
//
//  Created by YYang on 20/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "NSBundle+Load.h"

@implementation NSBundle (Load)
+(id)loadNibWithName:(NSString *)name andOwner:(id)owner{
    
    id xib =  [[self mainBundle]
            loadNibNamed:name owner:owner options:nil].firstObject;
    return xib;
}

+(NSString*)pathForPlist:(NSString *)plistName {
    NSString *path=[[self mainBundle] pathForResource:plistName ofType:@"plist"];
    return path;
}

+ (id )jsonWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[self mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"ERROR----->>>>>%@",error);
    return jsonObj;
}

+(NSArray *)mainResourcesForType:(NSString *)type directory:(NSString *)directory{

    return [[self mainBundle]pathsForResourcesOfType:type inDirectory:directory];
}


@end
