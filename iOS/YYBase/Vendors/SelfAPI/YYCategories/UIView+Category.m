//
//  UIView+Category.m
//  SalesAssisant
//
//  Created by musoon on 15/1/5.
//  Copyright (c) 2015年 ztesoft. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

#pragma mark 创建边距view，传入边距view的高度height、显示位置的y值、背景颜色color
- (id) initWithHeight:(CGFloat)height y:(CGFloat)y backgroundColor:(UIColor *)color {
    
    UIView *ret = [[UIView alloc] init];
    CGRect appBounds = [[UIScreen mainScreen] bounds];
    ret.frame = CGRectMake(0, y, appBounds.size.width, height);
    if (nil == color) color = [UIColor lightGrayColor];
    ret.backgroundColor = color;
    
    return ret;
    
    
    //    self = [super init];
    //    if (self) {
    //        CGRect appBounds = [[UIScreen mainScreen] bounds];
    //        self.frame = CGRectMake(0, y, appBounds.size.width, height);
    //        if (nil == color) {
    //            self.backgroundColor = color;
    //        } else {
    //            //颜色默认是浅灰色
    //            self.backgroundColor = [UIColor lightGrayColor];
    //        }
    //    }
    //    
    //    return self;
}

#pragma mark - 创建分割线，传入Frame、分割线的颜色、尺寸
- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    UIView *dividingLineView = [[UIView alloc] initWithFrame:frame];
    dividingLineView.backgroundColor = color;
    return dividingLineView;
}

#pragma mark - 创建分割线，传入Frame、分割线的颜色、尺寸
+ (id)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    return [[self alloc] initWithFrame:frame backgroundColor:color];
}

@end
