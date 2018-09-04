//
//  UIView+Category
//  SalesAssisant
//
//  Created by musoon on 15/1/5.
//  Copyright (c) 2015年 ztesoft. All rights reserved.
//  UIView 方法扩展

#import <UIKit/UIKit.h>

@interface UIView (Category)

#pragma mark 创建边距view，传入边距view的高度height、显示位置的y值、背景颜色color
- (id) initWithHeight: (CGFloat)height y: (CGFloat)y backgroundColor: (UIColor *)color;

#pragma mark 创建边距view，传入边距view的高度height、显示位置的y值、背景颜色color
+ (id) viewWithHeight: (CGFloat)height y: (CGFloat)y backgroundColor: (UIColor *)color;

#pragma mark - 创建分割线，传入Frame、分割线的颜色、尺寸
- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

#pragma mark - 创建分割线，传入Frame、分割线的颜色、尺寸
+ (id)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

@end
