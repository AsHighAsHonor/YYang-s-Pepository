//
//  UIImage+EmptyDataButtonBackgroundImage.m
//  trader-ios
//
//  Created by YYang1 on 13/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIImage+EmptyDataButtonBackgroundImage.h"

@implementation UIImage (EmptyDataButtonBackgroundImage)
+(UIImage *)buttonBackgroundImage:(UIImage *)normalImage highlightImage:(UIImage*)highlightImage capInsets:(UIEdgeInsets)capInsets rectInsets:(UIEdgeInsets)rectInsets forState:(UIControlState)state{
    UIImage *image;
    if (state == UIControlStateNormal){
        image = normalImage;
    }
    if (state == UIControlStateHighlighted){
        image = highlightImage;
    }
    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}
@end
