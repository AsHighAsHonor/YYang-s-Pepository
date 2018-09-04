//
//  UIStoryboard+InstantiateViewController.h
//  trader-ios
//
//  Created by YYang1 on 8/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (InstantiateViewController)
+(UIViewController *)loadController:(NSString *)controllerName storyBoard:(NSString*)storyboardName;
@end
