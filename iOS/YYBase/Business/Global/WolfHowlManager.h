//
//  WolfHowlManager.h
//  trader-ios
//
//  Created by YYang on 30/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WolfHowlManager : NSObject
SingletonH(Instance)

-(void)addNotificationObserve;
@end
