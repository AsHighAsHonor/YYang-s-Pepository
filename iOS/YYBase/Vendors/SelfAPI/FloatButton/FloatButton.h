//
//  FloatButton.h
//  GXMoblieOA
//
//  Created by YYang on 16/3/18.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FlotBtnClickedBlock)( );

@interface FloatButton : UIButton
/**
 *  @author YYang, 16-03-18 11:03:40
 *
 *  创建 floatbutton
 *
 *  @param title       标题
 *  @param color      背景色
 *  @param controller 父控制器
 *  @param btnClicked 点击事件
 *  @param name 背景图片
 *  @return 创建一个浮动在屏幕右下角的按钮
 */
+(instancetype)floatButtonWithTitle:(NSString *)title andBackGroundColor:(UIColor *)color andController:(UIViewController*)controller andIcon:(NSString *)name  andButtnClicked:(FlotBtnClickedBlock)btnClicked;
/**
 *  @author YYang, 16-03-18 11:03:32
 *
 *  显示 floatButton
 */
-(void)showFloatBtn;
/**
 *  @author YYang, 16-03-18 14:03:13
 *
 *  隐藏悬浮按钮
 */
-(void)dismissFloatBtn;
@end
