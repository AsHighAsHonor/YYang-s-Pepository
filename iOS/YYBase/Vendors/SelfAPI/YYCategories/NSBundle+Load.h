//
//  NSBundle+Load.h
//  haneco-ios
//
//  Created by YYang on 20/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Load)
+(id)loadNibWithName:(NSString *)name andOwner:(id)owner;

+(NSString*)pathForPlist:(NSString *)plistName;

+ (id )jsonWithName:(NSString *)name;

+(NSArray *)mainResourcesForType:(NSString *)type directory:(NSString *)directory;

@end
