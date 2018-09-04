//
//  UIView+Subveiw.m
//  trader-ios
//
//  Created by YYang1 on 1/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIView+Subveiw.h"

@implementation UIView (Subveiw)
- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

@end
