//
//  BtnAreaView.h
//  haneco-ios
//
//  Created by YYang on 16/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^bottomBtnBlock)(UIButton *sender);

@interface BtnAreaView : UIView
- (instancetype)initWithBtns:(NSArray *)btns andBottomBtnClicked:(bottomBtnBlock)bottomClicked;

@end
