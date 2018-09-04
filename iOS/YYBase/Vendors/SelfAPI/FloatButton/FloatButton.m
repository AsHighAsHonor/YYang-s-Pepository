//
//  FloatButton.m
//  GXMoblieOA
//
//  Created by YYang on 16/3/18.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import "FloatButton.h"
@interface FloatButton()
@property(nonatomic,strong)NSString *title;
@property(nonatomic,copy)FlotBtnClickedBlock btnClicked;
@property(nonatomic,strong)UIViewController *vc;
@property (nonatomic,strong)UIColor *color;
@property (nonatomic,strong)NSString *iconName;

@end

@implementation FloatButton
+(instancetype)floatButtonWithTitle:(NSString *)title andBackGroundColor:(UIColor *)color andController:(UIViewController*)controller andIcon:(NSString *)name  andButtnClicked:(FlotBtnClickedBlock)btnClicked
{
    return [[FloatButton alloc]initWithTitle:title andBackGroundColor:color andController:controller andIcon:name andButtnClicked:btnClicked];
}

-(instancetype)initWithTitle:(NSString *)title andBackGroundColor:(UIColor *)color andController:(UIViewController*)controller andIcon:(NSString *)name  andButtnClicked:(FlotBtnClickedBlock)btnClicked
{
    self = [super init];
    if(self)
    {
        self.title = title;
        self.btnClicked = btnClicked;
        self.vc = controller;
        self.color = color;
        self.iconName = name;
        [self generateFloatBtn];
    }
    return self;
}

-(void)generateFloatBtn
{
    [ self setTitle:self.title forState:UIControlStateNormal];
    [ self setBackgroundImage:[UIImage imageNamed:self.iconName] forState:UIControlStateNormal];
    [self.titleLabel setFont:kFont_10];
    self.layer.cornerRadius=20;
    self.clipsToBounds=YES;
    self.backgroundColor = self.color;
    self.frame = CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT-120, 40, 40);
    [self.vc.view addSubview:self];
    [self.vc.view bringSubviewToFront:self];

    [self addTarget:self action:@selector(floatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)floatBtnClicked:(UIButton *)btn
{
    if([self respondsToSelector:@selector(floatBtnClicked:)]){
        self.btnClicked();
//        [self dismissFloatBtn];
        
    }
}

-(void)showFloatBtn
{
        self.frame = CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT-120, 40, 40);
        [self.vc.view addSubview:self];
}

-(void)dismissFloatBtn
{
    [UIView animateWithDuration:2.0f delay:0 usingSpringWithDamping:1. initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
    self.frame = CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT+50, 40, 40);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
//    [self removeFromSuperview];
    
}



@end
