//
//  UIViewController+BaseMethod.m
//  haneco-ios
//
//  Created by YYang on 14/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "UIViewController+BaseMethod.h"
#import "UIImage+Color.h"
#import "UINavigationController+StackManager.h"
#import "HUD.h"
#import <CRToast/CRToast.h>
#import "UIImage+ImageDarken.h"

@implementation UIViewController (BaseMethod)

-(void)setBackgroundImage:(NSString *)imageName darkenLevel:(CGFloat)level{
    UIImage *image = [[UIImage imageNamed:imageName] imageDarkenWithLevel:level];
    UIColor *backImageColor = [UIColor colorWithPatternImage:image];
    self.view.backgroundColor = backImageColor;
}

#pragma mark - Navigation
- (void)setNavigationBarBackgourndColor:(UIColor*)color andTintColor:(UIColor*)tintColor{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor =color;
    self.navigationController.navigationBar.tintColor = tintColor;
}

-(void)setBackButtonWithImage:(NSString *)image{
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    backBtn.bounds = CGRectMake(0, 0, 30, 30);
    [backBtn addTarget:self action:@selector(backToLastController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)setBackbutton:(UIButton *)button{
    

//    //btn自适应文字
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:<#font#>]};
//    CGSize strSize = [<#title#> boundingRectWithSize:CGSizeMake(MAXFLOAT, btn.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    button.titleLabel.textColor = [UIColor blackColor];
    button.bounds = CGRectMake(0, 0, 60, 30);
    [button addTarget:self action:@selector(backToLastController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)backToLastController{
    [self popController];
}

-(void)setNavigationBarRightItemWithTitle:(NSString *)title andImage:(NSString *)iconName{
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 30, 35)];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [rightBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    rightItem.style = UIBarButtonItemStyleDone;
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)hideBackTitle{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)hideBackBtn{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)hideNavigationBarUnderline{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)showNavigationBarUnderline{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)setNavigationBarUnderlineColor:(UIColor*)color{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage imageWithColor:color]];
}

#pragma mark - NavigationStack
- (void) popController {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated: YES];
}

- (void) delayPop{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated: YES];
    });
}

- (void) delayDismiss{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)delayPopWithDuration:(NSUInteger)duration andLevel:(NSUInteger)level{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToViewControllerWithLevel:level animated:YES];
    });
}

-(void)popWithLevel:(NSUInteger )level{
    [self.navigationController popToViewControllerWithLevel:level animated:YES];
}

#pragma mark - Tabbar
-(void)hideTabBar{
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed=YES;
}

-(void)showTabBar{
    self.tabBarController.tabBar.hidden = NO;
    
}

#pragma mark - HUD
- (void)toast:(NSString *)msg {
    [[HUD sharedInstance] showToast:msg inView:self.view];
}

- (void)hud:(NSString *)msg{
    [[HUD sharedInstance] showHudWithMsg:msg inView:self.view];
}

-(void)ringHudMsg:(NSString *)msg  andTotalSize:(long long)totalSize andTotalReaded:(long long)totalReaded{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
            [[HUD sharedInstance] showRingHUDWithMsg:msg inView:self.view andTotalSize:totalSize andTotalReaded:totalReaded];
    });

}

-(void)errorTopToast:(NSString *)msg{
    NSDictionary *options = @{
                              kCRToastNotificationTypeKey: @(CRToastTypeNavigationBar),
                              kCRToastTextKey : @"ERROR: ",
                              kCRToastTextAlignmentKey : @(NSTextAlignmentLeft),
                              kCRToastBackgroundColorKey : PROGRESS_INDICATOR_COLOR,
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionBottom),
                              kCRToastTimeIntervalKey : @(3),
                              kCRToastSubtitleTextKey: msg,
                              kCRToastSubtitleTextAlignmentKey: @(NSTextAlignmentLeft),
                              kCRToastImageKey: ERROR_ICON,
                              kCRToastSubtitleTextColorKey : [UIColor blackColor],
                              kCRToastTextColorKey : [UIColor blackColor],
                              };
    [[HUD sharedInstance] topToast:options];
}

-(void)hideHud{
    [[HUD sharedInstance] hideHud];
    [[HUD sharedInstance]hideIndicatorFrom:self.view];
}


-(void)indicator:(UIColor *)color{
    [[HUD sharedInstance]showIndicatorTo:self.view color:color interaction:NO];
}

-(void)hideIndicator{
    [[HUD sharedInstance]hideIndicatorFrom:self.view];
    
}



@end
