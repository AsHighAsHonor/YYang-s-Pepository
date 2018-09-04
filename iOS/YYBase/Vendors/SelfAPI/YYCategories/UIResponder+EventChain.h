//
//  UIResponder+EventChain.h
//  haneco-ios
//
//  Created by YYang on 22/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (EventChain)
-(void)deliverEventWithName:(NSString *)name andInfo:(NSDictionary *)info;
@end
