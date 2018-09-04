//
//  UIButton+SelectButton.m
//  trader-ios
//
//  Created by YYang on 5/7/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIButton+SelectButton.h"
#import "NSString+Size.h"
#import "UIButton+ContentPostion.h"


@implementation UIButton (SelectButton)
-(void)refreshTitlePosition:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
    CGFloat titleWidth = [title widthWithFont:self.titleLabel.font constrainedToHeight:self.bounds.size.height];
    [self setImagePositionWithType:SSImagePositionTypeRight spacing:(SCREEN_WIDTH - 70 - titleWidth)];
}


@end
