//
//  NetMonitor.m
//  haneco-ios
//
//  Created by YYang on 14/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "NetMonitor.h"

@implementation NetMonitor
SingletonM(instance)

- (void)startMonitor
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                if ([self.delegate respondsToSelector:@selector(networkUnknown)]) {
                    [self.delegate networkUnknown];
                }
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                if ([self.delegate respondsToSelector:@selector(networkNotReachable)]) {
                    [self.delegate networkNotReachable];
                }
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                if ([self.delegate respondsToSelector:@selector(networkViaWWAN)]) {
                    [self.delegate networkViaWWAN];
                }
                break;
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                if ([self.delegate respondsToSelector:@selector(networkViaWiFi)]) {
                    [self.delegate networkViaWiFi];
                }
                break;
                break;
            }
            default: {
                break;
            }
        }
    }];
    
}
@end
