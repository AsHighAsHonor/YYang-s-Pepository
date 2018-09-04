//
//  UINavigationController+StackOperation.m
//  trader-ios
//
//  Created by YYang1 on 5/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UINavigationController+StackOperation.h"

@implementation UINavigationController (StackOperation)

-(void)removeAllControllersExcept:(NSArray < NSString *>*)controllers{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.viewControllers];
    NSMutableArray *vcs = [NSMutableArray array];
    for (UIViewController *stackVc in marr) {
        for (NSString *exceptVc in controllers) {
            if ([stackVc isKindOfClass:NSClassFromString(exceptVc)]) {
                [vcs addObject:stackVc];
            }
        }
    }
    self.viewControllers = vcs;
}


-(void)removeControllers:(NSArray < NSString *>*)controllers{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.viewControllers];
    NSMutableArray *vcs = [NSMutableArray array];
    for (UIViewController *stackVc in marr) {
        for (NSString *exceptVc in controllers) {
            if (![stackVc isKindOfClass:NSClassFromString(exceptVc)]) {
                [vcs addObject:stackVc];
            }
        }
    }
    self.viewControllers = vcs;
}


@end
