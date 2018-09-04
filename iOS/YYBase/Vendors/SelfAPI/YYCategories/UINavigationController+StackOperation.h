//
//  UINavigationController+StackOperation.h
//  trader-ios
//
//  Created by YYang1 on 5/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (StackOperation)
-(void)removeAllControllersExcept:(NSArray < NSString *>*)controllers;
-(void)removeControllers:(NSArray < NSString *>*)controllers;
@end
