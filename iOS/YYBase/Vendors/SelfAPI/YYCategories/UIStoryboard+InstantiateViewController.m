//
//  UIStoryboard+InstantiateViewController.m
//  trader-ios
//
//  Created by YYang1 on 8/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIStoryboard+InstantiateViewController.h"

@implementation UIStoryboard (InstantiateViewController)
+(UIViewController *)loadController:(NSString *)controllerName storyBoard:(NSString*)storyboardName{
    UIStoryboard *storyboard = [self storyboardWithName:storyboardName bundle:nil];
    UIViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:controllerName];
    return ctrl;
}
@end
