//
//  BtnAreaView.m
//  haneco-ios
//
//  Created by YYang on 16/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "BtnAreaView.h"
#import "BottomBtn.h"
#import <Masonry.h>


@interface BtnAreaView()
@property(nonatomic,strong)NSArray <BottomBtn*> *btns;
@property(nonatomic,copy)bottomBtnBlock myBtnClicked;
@property(nonatomic,assign)CGFloat btnHeights;
@property(nonatomic,assign)CGFloat btnWidths;
@property (nonatomic,strong)UIButton *vernier;
@end

#define TopAndBottomMargin 10
#define Padding 10
#define LeftAndRightMargin 15

@implementation BtnAreaView
- (instancetype)initWithBtns:(NSArray *)btns andBottomBtnClicked:(bottomBtnBlock)bottomClicked{
    self= [super init];
    if(self){
        self.btns = btns;
        self.myBtnClicked = bottomClicked;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self configureSubviews];
    }
    return self;
}

- (void)configureSubviews{
    [self setBackgroundColor:[UIColor redColor]];
    for (NSInteger i = 0; i< self.btns.count; i++) {
        //1. 创建 button 并添加到 self
        UIButton *btn = [self createBtnWithTitle:self.btns[i].title andIndex:i];
        //3. 给 button 添加约束
        [self addConstraintToBtn:btn];
        //4. 根据每个 button的intrinsicContentSize 累加得出整个 view 的intrinsicContentSize
        self.btnWidths += btn.intrinsicContentSize.width;
        self.btnHeights = btn.intrinsicContentSize.height;
    }
}

-(UIButton*)createBtnWithTitle:(NSString *)title andIndex:(NSInteger)index{
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.tag = index;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:0.042 green:0.636 blue:0.996 alpha:1.000];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:6.0];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setBorderWidth:1];
    [btn.layer setBorderColor:[UIColor clearColor].CGColor];
    [self addSubview:btn];
    return btn;
}

-(void)addConstraintToBtn:(UIButton *)btn {
    if (self.btns.count == 1) {
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(TopAndBottomMargin, LeftAndRightMargin, -TopAndBottomMargin, -LeftAndRightMargin));
        }];
        return;
    }
    
    if (btn.tag == 0) {
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(LeftAndRightMargin);
            make.top.mas_equalTo(TopAndBottomMargin);
            make.bottom.mas_equalTo(-TopAndBottomMargin);
        }];
    }else if (btn.tag == self.btns.count-1){
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-LeftAndRightMargin);
            make.left.mas_equalTo(self.vernier.mas_right).offset(Padding);
            make.centerY.height.mas_equalTo(self.vernier);
        }];
    }else{
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.vernier.mas_right).offset(Padding);
            make.centerY.height.mas_equalTo(self.vernier);
        }];
    }
    self.vernier = btn;
}


-(void)btnClicked:(UIButton*)sender{
    self.myBtnClicked(sender);
}

//重写intrinsicContentSize  给出当前 customview 的intrinsicContentSize
//如果需要动态的变化intrinsicContentSize 还需要在改变 size 的地方调用 invalidateIntrinsicContentSize 通知 autolayout system 重新计算
-(CGSize)intrinsicContentSize{
    CGFloat contentHeight =  self.btnHeights + 2* TopAndBottomMargin;
    CGFloat contentWidth = self.btnWidths + 2* LeftAndRightMargin + (self.btns.count-1)* Padding;
    
    return CGSizeMake(contentWidth, contentHeight);
}

@end
