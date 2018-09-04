//
//  UIView+ResponderChain.m
//  trader-ios
//
//  Created by YYang1 on 21/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIView+ResponderChain.h"

@implementation UIView (ResponderChain)

- (UIViewController *)getVC:(NSString *)vcName{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if([nextResponder isKindOfClass:NSClassFromString(vcName)]){
            return (UIViewController *) nextResponder;
        }
    }
    return nil;
}
@end
