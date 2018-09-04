//
//  HUD.m
//  haneco-ios
//
//  Created by YYang on 14/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "HUD.h"
#import <JGProgressHUD/JGProgressHUD.h>
#import <DGActivityIndicatorView.h>
#import <CRToast/CRToast.h>

static NSUInteger kIndicatorTag = 666;

@interface HUD()
@property (nonatomic,strong) JGProgressHUD *toast;
@property (nonatomic,strong) JGProgressHUD *hud;
@property (nonatomic,strong) JGProgressHUD *progressHud;
@property(nonatomic,strong) DGActivityIndicatorView *indicator;
@property(nonatomic,strong)NSArray *indicatorActivityTypes;
@end


@implementation HUD
SingletonM(Instance)

- (void)makeToast:(NSString *)msg {
    self.toast.indicatorView = nil;
    self.toast.textLabel.text = msg;
    self.toast.position = JGProgressHUDPositionBottomCenter;
    self.toast.interactionType = JGProgressHUDInteractionTypeBlockTouchesOnHUDView;
}

-(void)showInView:(UIView*)view{
    [self.toast showInView:view animated:YES];
}

-(void)dissmissDelay:(NSInteger)delay{
    [self.toast dismissAfterDelay:delay];
}

-(void)showToast:(NSString *)msg inView:(UIView*)view{
    [self makeToast:msg];
    [self showInView:view];
    [self dissmissDelay:3.0];
}


- (void)showHudWithMsg:(NSString *)msg inView:(UIView*)view{
    self.hud.textLabel.text = msg;
    self.hud.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
    [self.hud showInView:view animated:YES];
}

- (void)hideHud{
    if (self.hud.isVisible) {
        [self.hud dismiss];
    }
}

- (void)showRingHUDWithMsg:(NSString *)msg inView:(UIView*)view andTotalSize:(long long )totalSize andTotalReaded:(long long)totalReaded {
    
    JGProgressHUD *HUD = self.progressHud;
    HUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;

    double progress = totalReaded *1.0/totalSize;
    
    if(totalReaded != totalSize){
        HUD.textLabel.text = msg;
        HUD.indicatorView = [[JGProgressHUDRingIndicatorView alloc] initWithHUDStyle:HUD.style];
        HUD.layoutChangeAnimationDuration = 0.0;
        [HUD setProgress:progress animated:NO];
        HUD.detailTextLabel.text = [NSString stringWithFormat:@"Progress: %.2f%%", progress*100];
    }else{
        HUD.textLabel.text = @"Success!";
        HUD.detailTextLabel.text = nil;
        HUD.layoutChangeAnimationDuration = 0.3;
        HUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD dismiss];
        });
    }
    
    if (!HUD.isVisible) {
        [HUD showInView:view];
    }
    
}

- (void)showIndicatorTo:(UIView *)view color:(UIColor *)color interaction:(BOOL)enabled {
    [view setUserInteractionEnabled:enabled];
    
    if([view viewWithTag:kIndicatorTag]){
        return;
    }

    
    CGFloat width = SCREEN_WIDTH *0.15;
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CGPoint center = window.center;
    CGPoint indecatorCenter = [window convertPoint:center toView:view];
//    DGActivityIndicatorView * indicator  = [[DGActivityIndicatorView alloc]initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:color size:width];
//    indicator.center = indecatorCenter;
    DGActivityIndicatorView * indicator  = [[DGActivityIndicatorView alloc]initWithType:DGActivityIndicatorAnimationTypeBallClipRotate tintColor:color];

    indicator.frame = CGRectMake((SCREEN_WIDTH - width)/2, 36, width, width);
    indicator.tag = kIndicatorTag;
    indicator.tintColor = color;
    [view addSubview:indicator];
    [indicator startAnimating];
}

-(void)hideIndicatorFrom:(UIView *)view{
    [view setUserInteractionEnabled:YES];
    DGActivityIndicatorView * indicator = [view viewWithTag:kIndicatorTag];
    [indicator stopAnimating];
    [indicator removeFromSuperview];
}

-(void)topToast:(NSDictionary *)options{
    [CRToastManager showNotificationWithOptions:options apperanceBlock:^{
        
    } completionBlock:^{
        
    }];
}



#pragma mark - lazy
-(JGProgressHUD *)toast{
    if (!_toast) {
        _toast = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleExtraLight];
        
    }
    return _toast;
}

- (JGProgressHUD *)hud {
    if (!_hud) {
        _hud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleExtraLight];
    }
    return _hud;
}


-(JGProgressHUD *)progressHud{
    if(!_progressHud){
        _progressHud  = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleExtraLight];
    }
    return _progressHud;
}


-(DGActivityIndicatorView *)indicator{
    if(!_indicator){
        int index = arc4random() % self.indicatorActivityTypes.count;
        _indicator  = [[DGActivityIndicatorView alloc]initWithType:(DGActivityIndicatorAnimationType)([self.indicatorActivityTypes[index] integerValue])];

    }
    return _indicator;
}



-(NSArray *)indicatorActivityTypes{
    if(!_indicatorActivityTypes){
        _indicatorActivityTypes  = @[@(DGActivityIndicatorAnimationTypeNineDots),
                                   @(DGActivityIndicatorAnimationTypeTriplePulse),
                                   @(DGActivityIndicatorAnimationTypeFiveDots),
                                   @(DGActivityIndicatorAnimationTypeRotatingSquares),
                                   @(DGActivityIndicatorAnimationTypeDoubleBounce),
                                   @(DGActivityIndicatorAnimationTypeTwoDots),
                                   @(DGActivityIndicatorAnimationTypeThreeDots),
                                   @(DGActivityIndicatorAnimationTypeBallPulse),
                                   @(DGActivityIndicatorAnimationTypeBallClipRotate),
                                   @(DGActivityIndicatorAnimationTypeBallClipRotatePulse),
                                   @(DGActivityIndicatorAnimationTypeBallClipRotateMultiple),
                                   @(DGActivityIndicatorAnimationTypeBallRotate),
                                   @(DGActivityIndicatorAnimationTypeBallZigZag),
                                   @(DGActivityIndicatorAnimationTypeBallZigZagDeflect),
                                   @(DGActivityIndicatorAnimationTypeBallTrianglePath),
                                   @(DGActivityIndicatorAnimationTypeBallScale),
                                   @(DGActivityIndicatorAnimationTypeLineScale),
                                   @(DGActivityIndicatorAnimationTypeLineScaleParty),
                                   @(DGActivityIndicatorAnimationTypeBallScaleMultiple),
                                   @(DGActivityIndicatorAnimationTypeBallPulseSync),
                                   @(DGActivityIndicatorAnimationTypeBallBeat),
                                   @(DGActivityIndicatorAnimationTypeLineScalePulseOut),
                                   @(DGActivityIndicatorAnimationTypeLineScalePulseOutRapid),
                                   @(DGActivityIndicatorAnimationTypeBallScaleRipple),
                                   @(DGActivityIndicatorAnimationTypeBallScaleRippleMultiple),
                                   @(DGActivityIndicatorAnimationTypeTriangleSkewSpin),
                                   @(DGActivityIndicatorAnimationTypeBallGridBeat),
                                   @(DGActivityIndicatorAnimationTypeBallGridPulse),
                                   @(DGActivityIndicatorAnimationTypeRotatingSandglass),
                                   @(DGActivityIndicatorAnimationTypeRotatingTrigons),
                                   @(DGActivityIndicatorAnimationTypeTripleRings),
                                   @(DGActivityIndicatorAnimationTypeCookieTerminator),
                                   @(DGActivityIndicatorAnimationTypeBallSpinFadeLoader)];
    }
    return _indicatorActivityTypes;
}


@end

