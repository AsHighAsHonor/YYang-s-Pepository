//
//  UIView+Gesture.h
//  trader-ios
//
//  Created by YYang1 on 19/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gesture)
-(void)addTapGesturetarget:(id)target withSelector:(SEL)selector enableInteraction:(BOOL)enabled;

@end
