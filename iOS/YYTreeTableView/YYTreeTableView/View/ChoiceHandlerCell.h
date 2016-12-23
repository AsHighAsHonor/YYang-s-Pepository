//
//  ChoiceHandlerCell.h
//  GXMoblieOA
//
//  Created by YYang on 16/3/29.
//  Copyright © 2016年 YYang. All rights reserved.
//

//treeCell
#import <UIKit/UIKit.h>

@interface ChoiceHandlerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *foldBtn;
@property (weak, nonatomic) IBOutlet UILabel *handlerNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkBoxLeftConstraint;

@property (nonatomic, assign, getter=isExpandable) BOOL expandable;

@end
