//
//  UITextField+Limitation.h
//  trader-ios
//
//  Created by YYang on 11/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UITextField (Limitation)
/**
 设置最大长度
 */
@property (nonatomic, assign) IBInspectable NSUInteger maxLength;


@end
