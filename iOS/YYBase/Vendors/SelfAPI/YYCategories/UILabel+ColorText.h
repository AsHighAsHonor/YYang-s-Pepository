//
//  UILabel+ColorText.h
//  trader-ios
//
//  Created by YYang on 5/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ColorText)
+ (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFontSize:(float)fontSize;

+ (void)messageAction:(UILabel *)theLab startString:(NSString *)start endString:(NSString *)end andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFontSize:(float)fontSize;

+ (void)setRichNumberWithLabel:(UILabel*)label Color:(UIColor *)color FontSize:(CGFloat)size;
@end
