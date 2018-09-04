//
//  UISearchBar+Appearance.m
//  trader-ios
//
//  Created by YYang1 on 10/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UISearchBar+Appearance.h"

@implementation UISearchBar (Appearance)
-(void)removeBackground{
    for (UIView *view in self.subviews){
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0){
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
}
@end
