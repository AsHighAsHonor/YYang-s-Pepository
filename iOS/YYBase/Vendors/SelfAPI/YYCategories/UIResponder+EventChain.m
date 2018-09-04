//
//  UIResponder+EventChain.m
//  haneco-ios
//
//  Created by YYang on 22/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "UIResponder+EventChain.h"

@implementation UIResponder (EventChain)
-(void)deliverEventWithName:(NSString *)name andInfo:(NSDictionary *)info{
    [[self nextResponder] deliverEventWithName:name andInfo:info];
}

@end
