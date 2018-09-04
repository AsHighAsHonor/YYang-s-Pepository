//
//  UIApplication+Hierarchy.h
//  trader-ios
//
//  Created by YYang1 on 18/4/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootViewController;


@interface UIApplication (Hierarchy)
+(RootViewController* )applicationRootViewController;
+(UIViewController* )currentCtrl;
@end
