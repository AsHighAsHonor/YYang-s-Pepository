//
//  ControllerIntercepter.m
//
//
//  Created by YYang on 16/5/7.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import "ControllerIntercepter.h"
#import "Aspects.h"
#import <UIKit/UIKit.h>





@interface ControllerIntercepter ()
@property(nonatomic,strong)id instance;
@property(nonatomic,strong)UIViewController *ctrl;
@end

@implementation ControllerIntercepter
+ (void)load{
    [super load];
    [ControllerIntercepter sharedInstance];
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static ControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            self.instance = aspectInfo.instance;
            self.ctrl = aspectInfo.instance;
            [self viewControllerTrack];
        } error:NULL];
        

    }
    return self;
}

- (void)viewControllerTrack{
//    NSLog(@"%@",self.instance);
}





@end
