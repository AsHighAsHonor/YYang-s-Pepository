//
//  UINavigationController+StatusBar.m
//  NavigationBar
//
//  Created by YYang on 17/6/18.
//  Copyright © 2018 YYang. All rights reserved.
//

#import "UINavigationController+StatusBar.h"

@implementation UINavigationController (StatusBar)

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


-(void)translucentNavigationbar{
    self.navigationBar.translucent=YES;
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
}

-(void)displayNavigationbar{
    self.navigationBar.translucent=NO;
}

@end
