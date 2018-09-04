//
//  UIView+Gesture.m
//  trader-ios
//
//  Created by YYang1 on 19/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIView+Gesture.h"

@implementation UIView (Gesture)
-(void)addTapGesturetarget:(id)target withSelector:(SEL)selector enableInteraction:(BOOL)enabled {
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    onTap.numberOfTapsRequired = 1;
    self.userInteractionEnabled = enabled;
    [self addGestureRecognizer:onTap];
}
@end
