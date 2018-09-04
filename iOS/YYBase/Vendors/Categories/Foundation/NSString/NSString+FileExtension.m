//
//  NSString+FileExtension.m
//  GXMoblieOA
//
//  Created by Mon-work on 5/19/16.
//  Copyright © 2016 YYang. All rights reserved.
//

#import "NSString+FileExtension.h"

@implementation NSString (FileExtension)

- (BOOL)anyExtensionOf:(NSArray *)extensions{
    
    NSString *fileSuffix = [self pathExtension];
    for (NSString *extension in extensions) {
        if ([[fileSuffix lowercaseString] isEqualToString:extension]) {
            return YES;
        }
    }
    
    return NO;
}

@end
