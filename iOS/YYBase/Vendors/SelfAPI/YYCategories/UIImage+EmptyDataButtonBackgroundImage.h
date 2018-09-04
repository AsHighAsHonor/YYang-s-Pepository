//
//  UIImage+EmptyDataButtonBackgroundImage.h
//  trader-ios
//
//  Created by YYang1 on 13/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EmptyDataButtonBackgroundImage)
+(UIImage *)buttonBackgroundImage:(UIImage *)normalImage highlightImage:(UIImage*)highlightImage capInsets:(UIEdgeInsets)capInsets rectInsets:(UIEdgeInsets)rectInsets forState:(UIControlState)state;
@end
