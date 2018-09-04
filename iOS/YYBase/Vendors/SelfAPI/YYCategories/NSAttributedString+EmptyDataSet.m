//
//  NSAttributedString+EmptyDataSet.m
//  trader-ios
//
//  Created by YYang1 on 5/7/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "NSAttributedString+EmptyDataSet.h"

@implementation NSAttributedString (EmptyDataSet)
+ (NSAttributedString *)titleForEmptyData:(NSString *)text{
    
    UIFont *font = kFont_17;
    UIColor *textColor = DARK_GRAY_COLOR;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[self alloc]initWithString:text attributes:attributes];
}


+ (NSAttributedString *)descriptionForEmptyData:(NSString *)text{
    UIFont *font = kFont_15;
    UIColor *textColor = LIGHT_GRAY_COLOR;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[self alloc]initWithString:text attributes:attributes];
}


@end
