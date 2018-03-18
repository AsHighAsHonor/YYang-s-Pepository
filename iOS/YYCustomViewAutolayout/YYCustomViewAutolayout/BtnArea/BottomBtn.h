//
//  BottomBtn.h
//  haneco-ios
//
//  Created by YYang on 17/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    BBAdd,
    BBSave,
    BBSelect,
    BBAllselect,
} BottomBtnType;


@interface BottomBtn : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) BottomBtnType type;
+(instancetype)btnWithTitle:(NSString *)title andType:(BottomBtnType)type;

@end
