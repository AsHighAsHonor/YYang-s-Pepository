//
//  UIApplication+Hierarchy.m
//  trader-ios
//
//  Created by YYang1 on 18/4/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIApplication+Hierarchy.h"
@class RootViewController;
@implementation UIApplication (Hierarchy)
+(RootViewController* )applicationRootViewController{
    for (UIWindow *window in [self sharedApplication].windows) {
        UIViewController *ctrl = (window.rootViewController);
        if ([ctrl isKindOfClass:[RootViewController class]]) {
            return(RootViewController *) ctrl;
        }
    }
    NSAssert(NO, @"RootViewController not exist!");
    return nil;
    
}

+(UIViewController* )currentCtrl{
    UIViewController *result = nil;
    
    UIWindow *window = [[self sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
    
}

@end
