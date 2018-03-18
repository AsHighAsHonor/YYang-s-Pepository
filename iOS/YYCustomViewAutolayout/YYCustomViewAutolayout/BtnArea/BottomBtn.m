//
//  BottomBtn.m
//  haneco-ios
//
//  Created by YYang on 17/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "BottomBtn.h"
@interface BottomBtn()

@end

@implementation BottomBtn

- (instancetype)init
{
    NSAssert(NO, @"Use btnWithTitle: pls");
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype)btnWithTitle:(NSString *)title andType:(BottomBtnType)type{
    return [[self alloc]initWithTitle:title andType:type];
}

- (instancetype)initWithTitle:(NSString *)title andType:(BottomBtnType)type
{
    self = [super init];
    if (self) {
        self.title = title;
        self.type = type;
    }
    return self;
}
@end
