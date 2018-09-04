//
//  NSString+FileExtension.h
//  GXMoblieOA
//
//  Created by Mon-work on 5/19/16.
//  Copyright © 2016 YYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FileExtension)

/**
 *  @author Mon
 *
 *  根据文件路径判断文件是否为特定的文件类型
 *
 *  @param extensions 需要匹配的一个或多个文件类型
 *
 *  @return YES 若文件属于其中的一种类型， NO 若文件不属于任何一种类型
 */
- (BOOL)anyExtensionOf:(NSArray *)extensions;

@end
