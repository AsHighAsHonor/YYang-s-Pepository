//
//  ViewController.m
//  YYCustomViewAutolayout
//
//  Created by YYang on 18/3/18.
//  Copyright © 2018 YYang. All rights reserved.
//

#import "ViewController.h"
#import "BtnAreaView.h"
#import "BottomBtn.h"
#import <Masonry.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property(nonatomic,strong)BtnAreaView * btnArea;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self btnArea];
}


-(BtnAreaView *)btnArea
{
    if(!_btnArea)
    {
        _btnArea  =({
            // TODO:  test !!!!  generateBtns
            NSMutableArray * btns = [NSMutableArray array];
            for (NSInteger i = 0; i< 10; i++) {
                [btns  addObject:[BottomBtn btnWithTitle:[NSString stringWithFormat:@"BB--%ld",(long)i] andType:BBAdd]];
            }
            
            BtnAreaView *var =[[BtnAreaView alloc]initWithBtns:btns andBottomBtnClicked:^(UIButton *sender) {
                NSLog(@"%ld",(long)sender.tag);
            }];
            [self.myScrollView addSubview:var];
            //UIScrollView 有一个 contentSize 属性，其定义了 ScrollView 可滚动内容的大小。在以前用纯代码写的时候，会直接对这个属性赋值，定义其大小。但在 Autolayout 下，UIScrollView 的 contentSize 是由其内容的约束来定义的。因此，在 ScrollView 里面设置的约束，不仅起到布局内容的作用，同时也起到了定义 ScrollView 可滚动范围的作用。
            
            //1.手动设置 contentSize  约束就可以控制BtnAreaView 的位置
            self.myScrollView.contentSize = var.intrinsicContentSize;
            [var mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.myScrollView);
                make.left.equalTo(0);
            }];
            //2.这种方式设置约束默认BtnAreaView 位于 myScrollView的顶部,改变位置会拉伸压缩BtnAreaView
//            [var mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.mas_equalTo(self.myScrollView);
//            }];
            
            var;
        });
    }
    return _btnArea;
}



@end
