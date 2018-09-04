//
//  UIImage+Icon.m
//  trader-ios
//
//  Created by YYang on 16/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIImage+Icon.h"
#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"

@implementation UIImage (Icon)
+(UIImage *)facebookIconWithBackgroundColor:(UIColor *)back iconColor:(UIColor *)front fontSize:(int)size{
    UIImage *icon = [UIImage imageWithIcon:@"fa-facebook-official" backgroundColor:back iconColor:front fontSize:size];
    return icon;
}



@end
