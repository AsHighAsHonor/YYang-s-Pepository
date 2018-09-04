//
//  YYTouchID.m
//  haneco-ios
//
//  Created by YYang on 29/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "YYTouchID.h"

@interface YYTouchID()


@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *title;
@end

@implementation YYTouchID
SingletonM(Instance)


- (void)startTouchIDWithMessage:(NSString *)message andFallBackTitle:(NSString *)title andDelegate:(id<YYTouchIdDelegate>)delegate{
    LAContext *context = [[LAContext alloc] init];
    self.msg = message;
    self.title = title;
    context.localizedFallbackTitle = self.title;
    NSError *error = nil;
    self.touchIdDelegate = delegate;
    
    NSAssert(self.touchIdDelegate, @"Set YYTouchId delegate before you use it!");

    BOOL canEvaluate =  [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (canEvaluate && error.code != -8) {
        //TouchID OR FaceID
        [self canEvaluateWith:context];
    }else{
        //Password
//        [self canNotEvaluate:context];
        [self evaluateResult:NO andError:error];
    }

}

-(BOOL)canAuthorizeDelegate:(id<YYTouchIdDelegate>)delegate{
    if (delegate) {
        self.touchIdDelegate = delegate;
    }
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    BOOL canEvaluate =  [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    [self evaluateResult:NO andError:error];
    return canEvaluate;
}


- (void)canEvaluateWith:(LAContext *)context{
    if (@available(iOS 11.0, *)) {
        switch (context.biometryType) {
            case LABiometryNone:{
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeNotSupport)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeNotSupport];
                    }];
                }

            }
                break;
            case LABiometryTypeTouchID:{
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:self.msg reply:^(BOOL success, NSError * _Nullable error) {
                    [self evaluateResult:success andError:error];
                }];
            }
                break;
            case LABiometryTypeFaceID:{
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:self.msg reply:^(BOOL success, NSError * _Nullable error) {
                    [self evaluateResult:success andError:error];
                }];
            }
                break;
            default:
                break;
        }
        
    }else{
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:self.msg reply:^(BOOL success, NSError * _Nullable error) {
            [self evaluateResult:success andError:error];
        }];

    }

    
}

-(void)canNotEvaluate:(LAContext *)context{
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:self.msg reply:^(BOOL success, NSError * _Nullable error) {
        [self evaluateResult:success andError:error];
    }];
}

-(void)evaluateResult:(BOOL) success andError:(NSError *) error{
    //识别成功:
    if (success) {
        NSLog(@"authorizeSuccess----->>>>>");
        if ([self.touchIdDelegate respondsToSelector:@selector(authorizeSuccess)]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.touchIdDelegate authorizeSuccess];
            }];
        }
    }else{
        //识别失败（对应代理方法的每种情况,不实现对应方法就没有反应）
        switch (error.code) {
            case LAErrorAuthenticationFailed:{
                NSLog(@"authorizeFailure----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeFailure)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeFailure];
                    }];
                }
                break;
            }
            case LAErrorUserCancel:{
                NSLog(@"authorizeUserCancel----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeUserCancel)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeUserCancel];
                    }];
                }
                break;
            }
            case LAErrorUserFallback:{
                NSLog(@"authorizeUserFallBack----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeUserFallBack)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeUserFallBack];
                    }];
                }
                break;
            }
            case LAErrorSystemCancel:{
                NSLog(@"authorizeSystemCancel----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeSystemCancel)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeSystemCancel];
                    }];
                }
                break;
            }
            case LAErrorTouchIDNotEnrolled:{
                NSLog(@"authorizeTouchIDNotEnrolled----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeTouchIDNotEnrolled)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeTouchIDNotEnrolled];
                    }];
                }
                break;
            }
            case LAErrorPasscodeNotSet:{
                NSLog(@"authorizePasswordNotSet----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizePasswordNotSet)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizePasswordNotSet];
                    }];
                }
                break;
            }
            case LAErrorTouchIDNotAvailable:{
                NSLog(@"authorizeTouchIDNotAvailable----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeTouchIDNotAvailable)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeTouchIDNotAvailable];
                    }];
                }
                break;
            }
            case LAErrorTouchIDLockout:{
                NSLog(@"authorizeTouchIDLockOut----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeTouchIDLockOut)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeTouchIDLockOut];
                    }];
                }
                break;
            }
            case LAErrorAppCancel:{
                NSLog(@"authorizeTouchIDAppCancel----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeTouchIDAppCancel)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeTouchIDAppCancel];
                    }];
                }
                break;
            }
            case LAErrorInvalidContext:{
                NSLog(@"authorizeTouchIDInvalidContext----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeTouchIDInvalidContext)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeTouchIDInvalidContext];
                    }];
                }
                break;
            }
            case LAErrorNotInteractive:{
                NSLog(@"authorizeNotInteractive----->>>>>%@",error.localizedDescription);
                if ([self.touchIdDelegate respondsToSelector:@selector(authorizeNotInteractive)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.touchIdDelegate authorizeNotInteractive];
                    }];
                }
                break;
            }
            default:
                break;
        }
    }
}



@end
