//
//  ChoiceHandlerCell.m
//  GXMoblieOA
//
//  Created by YYang on 16/3/29.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import "ChoiceHandlerCell.h"

@implementation ChoiceHandlerCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.expandable = YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    float indentPoints = self.indentationLevel *self.indentationWidth;
    for(UIView *view in self.subviews){
        view.frame = CGRectMake(
                                view.frame.origin.x+indentPoints,
                                view.frame.origin.y,
                                view.frame.size.width,
                                view.frame.size.height
                                );
    }
}


- (void)setExpandable:(BOOL)expandable{
    _expandable = expandable;
    
    if (_expandable) {
        [self.foldBtn setBackgroundImage:[UIImage imageNamed:@"my_work_3"] forState:UIControlStateNormal];
    } else {
        [self.foldBtn setBackgroundImage:[UIImage imageNamed:@"my_work_1"] forState:UIControlStateNormal];
    }
}

@end
