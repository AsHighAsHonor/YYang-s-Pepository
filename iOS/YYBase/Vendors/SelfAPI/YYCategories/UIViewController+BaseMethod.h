//
//  UIViewController+BaseMethod.h
//  haneco-ios
//
//  Created by YYang on 14/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BaseMethod)
- (void)setNavigationBarBackgourndColor:(UIColor*)color andTintColor:(UIColor*)tintColor;

-(void)setBackButtonWithImage:(NSString *)name;

-(void)setBackbutton:(UIButton *)button;

-(void)setNavigationBarRightItemWithTitle:(NSString *)title andImage:(NSString *)iconName;

-(void)hideBackTitle;

- (void)hideBackBtn;

- (void)hideNavigationBarUnderline;

- (void)showNavigationBarUnderline;

-(void)setNavigationBarUnderlineColor:(UIColor*)color;

- (void) popController;

- (void) delayPop;

- (void) delayDismiss;

- (void)delayPopWithDuration:(NSUInteger)duration andLevel:(NSUInteger)level;

-(void)popWithLevel:(NSUInteger )level;

-(void)hideTabBar;

-(void)showTabBar;

- (void)toast:(NSString *)msg;

- (void)hud:(NSString *)msg;

-(void)hideHud;

-(void)ringHudMsg:(NSString *)msg  andTotalSize:(long long)totalSize andTotalReaded:(long long)totalReaded;

-(void)errorTopToast:(NSString *)msg;

-(void)indicator:(UIColor *)color;

//-(void)hideIndicator;

-(void)setBackgroundImage:(NSString *)imageName darkenLevel:(CGFloat)level;




@end
