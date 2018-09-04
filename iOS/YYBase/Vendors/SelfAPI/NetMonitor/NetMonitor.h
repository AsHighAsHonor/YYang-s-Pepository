//
//  NetMonitor.h
//  haneco-ios
//
//  Created by YYang on 14/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MonitorDelegate <NSObject>
-(void)networkUnknown;

-(void)networkNotReachable;

-(void)networkViaWWAN;

-(void)networkViaWiFi;
@end

@interface NetMonitor : NSObject
SingletonH(instance)
@property(nonatomic,assign) id <MonitorDelegate>delegate;

-(void)startMonitor;
@end
