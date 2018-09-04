//
//  HUD.h
//  haneco-ios
//
//  Created by YYang on 14/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUD : NSObject

SingletonH(Instance)

#pragma mark - Toast
- (void)makeToast:(NSString *)msg;

-(void)showInView:(UIView*)view;

-(void)dissmissDelay:(NSInteger)delay;

-(void)showToast:(NSString *)msg inView:(UIView*)view;

#pragma mark - HUD
- (void)showHudWithMsg:(NSString *)msg inView:(UIView*)view;

- (void)hideHud;

- (void)showRingHUDWithMsg:(NSString *)msg inView:(UIView*)view andTotalSize:(long long )totalSize andTotalReaded:(long long)totalReaded;

- (void)showIndicatorTo:(UIView *)view color:(UIColor *)color interaction:(BOOL)enabled;

-(void)hideIndicatorFrom:(UIView *)view;

-(void)topToast:(NSDictionary *)options;
@end
