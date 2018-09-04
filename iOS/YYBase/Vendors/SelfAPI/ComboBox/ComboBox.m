//
//  ComboBox.m
//  DropdownListButton
//
//  Created by Mon on 10/16/15.
//  Copyright © 2015 Mon. All rights reserved.
//

#import "ComboBox.h"
#import "NSString+Category.h"

#define CORNERRADIUS 5
#define kTableViewRowHeigth 30
#define kTableViewMaxHeigth 120

NSString *const ComboxDictKey = @"key";
NSString *const ComboxDictValue = @"value";

@interface ComboBox ()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation ComboBox

#pragma mark - 属性方法
- (UITableView *)dropList{
    if (!_dropList) {
        
        int x = CGRectGetMinX(self.contentLabel.frame);
        int y = CGRectGetMaxY(self.contentLabel.frame) + 1;
        CGFloat width = CGRectGetWidth(self.contentLabel.frame);
        CGFloat comTableViewHeight = self.dataSource.count * kTableViewRowHeigth;
        CGFloat height = comTableViewHeight > kTableViewMaxHeigth ? kTableViewMaxHeigth : comTableViewHeight;
        
        _dropList = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _dropList.delegate = self;
        _dropList.dataSource = self;
        
        _dropList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _dropList.layer.borderColor = [UIColor grayColor].CGColor;
        _dropList.layer.borderWidth = 0.5;
        _dropList.layer.cornerRadius = CORNERRADIUS;
        _dropList.rowHeight = kTableViewRowHeigth;
        
        _dropList.separatorInset = UIEdgeInsetsZero;
        _dropList.layoutMargins = UIEdgeInsetsZero;
    }
    
    return _dropList;
}

- (UIButton *)hideBtn{
    
    if (!_hideBtn) {
        _hideBtn = [[UIButton alloc] initWithFrame:self.sender.view.bounds];
        [_hideBtn addTarget:self action:@selector(hideDropList) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _hideBtn;
}

- (void)setEnableBorderColor:(UIColor *)enableBorderColor{
    
    
    if (enableBorderColor) {
        _enableBorderColor = enableBorderColor;
    }else{
        _enableBorderColor = self.tintColor;
    }
    
    if (self.enable) {
        self.mainButton.layer.borderColor = _enableBorderColor.CGColor;
    }
}

- (void)setDisableBorderColor:(UIColor *)disableBorderColor{
    
    if (disableBorderColor) {
        _disableBorderColor = disableBorderColor;
        _contentLabel.textColor = disableBorderColor;
    }else{
        _disableBorderColor = [UIColor grayColor];
        _contentLabel.textColor = [UIColor grayColor];
    }
    
    if (!self.enable) {
        self.mainButton.layer.borderColor = _disableBorderColor.CGColor;
    }
}

- (void)setEnable:(BOOL)enable{
    _enable = enable;
    
    self.mainButton.userInteractionEnabled = _enable;
    
    if (_enable) {
        if (self.enableBorderColor) {
            self.mainButton.layer.borderColor = self.enableBorderColor.CGColor;
        }else{
            self.mainButton.layer.borderColor = self.tintColor.CGColor;
        }
    }else{
        if (self.disableBorderColor) {
            self.mainButton.layer.borderColor = self.disableBorderColor.CGColor;
        }else{
            self.mainButton.layer.borderColor = [UIColor grayColor].CGColor;
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource sender:(UIViewController *)sender {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.dataSource = dataSource;
        
        self.dropListAppear = NO;
        
        self.enable = YES;
        
        [self setupSubviews];
        
        if (sender) self.sender = sender;
    }
    
    return self;
}

#pragma mark - UI 设置
#pragma mark 设置子视图
- (void)setupSubviews{
    
    self.layer.cornerRadius = CORNERRADIUS;
    
    //添加内容标签
    int x = 0;
    int y = 0;
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame) - height;
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    
    if (!self.dataSource || self.dataSource.count == 0) {
        _contentLabel.text = @"";
    } else {
        _contentLabel.text = self.dataSource[0][ComboxDictKey];
    }
    
    [self addSubview:_contentLabel];
    
    //分割线
    x = CGRectGetMaxX(_contentLabel.frame);
    y = CGRectGetMinY(_contentLabel.frame);
    width = 1;
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, CGRectGetHeight(self.frame))];
    separator.backgroundColor = [UIColor grayColor];
    [self addSubview:separator];
    
    x = CGRectGetMaxX(separator.frame);
    y = CGRectGetMinY(separator.frame);
    
    _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, height, height)];
    _arrowImageView.image = [UIImage imageNamed:@"down_p_blue"];
    
    [self addSubview:_arrowImageView];
    
    //添加按钮
    x = 0;
    y = 0;
    width = CGRectGetWidth(self.frame);
    height = CGRectGetHeight(self.frame);
    
    _mainButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _mainButton.layer.cornerRadius = CORNERRADIUS;
    _mainButton.layer.borderColor = [UIColor grayColor].CGColor;
    _mainButton.layer.borderWidth = 1;
    _mainButton.backgroundColor = [UIColor clearColor];
    [_mainButton addTarget:self action:@selector(actionShowOrHideList) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_mainButton];
}

#pragma mark - 辅助方法

- (void)actionShowOrHideList{
    
    if (!self.enable) {
        return;
    }
    
    if (!self.isDropListAppear) {
        [self showDropList];
    }else{
        [self hideDropList];
    }
}

#pragma mark 显示下拉列表
- (void)showDropList{
    
    // 判断数组中是否有数据
    if (!self.dataSource || self.dataSource.count == 0) return;
    
    NSLog(@"show");
    
    //显示下拉列表
    self.dropListAppear = YES;
    
    // 加遮罩
    [self.sender.view addSubview:self.hideBtn];
    
    // 计算 dropList 显示位置
    
    //计算 comboBox 在 sender 的上半部/下半部
    CGPoint comboBoxXY = [self.contentLabel convertPoint:CGPointMake(CGRectGetMinX(self.contentLabel.frame), CGRectGetMinY(self.contentLabel.frame)) toView:self.sender.view];
    if (comboBoxXY.y <= self.sender.view.center.y) {
        //上半部，朝下显示
        CGPoint dropListXY = [self.contentLabel convertPoint:CGPointMake(CGRectGetMinX(self.contentLabel.frame), CGRectGetMaxY(self.contentLabel.frame)) toView:self.sender.view];
        self.dropList.frame = CGRectMake(dropListXY.x, dropListXY.y + 1, CGRectGetWidth(self.dropList.frame), CGRectGetHeight(self.dropList.frame));
    }else{
        //下半部，朝上显示
        CGPoint dropListXY = [self.contentLabel convertPoint:CGPointMake(CGRectGetMinX(self.contentLabel.frame), CGRectGetMinY(self.contentLabel.frame)) toView:self.sender.view];
        self.dropList.frame = CGRectMake(dropListXY.x, dropListXY.y - 1 - CGRectGetHeight(self.dropList.frame), CGRectGetWidth(self.dropList.frame), CGRectGetHeight(self.dropList.frame));
    }
    
    
    
    // 添加选项视图，并移动到顶层
    [self.sender.view addSubview:self.dropList];
    [self.sender.view bringSubviewToFront:self.dropList];
}

#pragma mark 隐藏下拉列表
- (void)hideDropList{
    
    NSLog(@"hide");
    
    self.dropListAppear = NO;
    
    //将遮罩层 与 下拉列表 移出
    [self.hideBtn removeFromSuperview];
    [self.dropList removeFromSuperview];
}


#pragma mark 重新加载下拉列表数据
- (void)reload{
    [self.dropList reloadData];
    
    [self hideDropList];
    
    self.contentLabel.text = self.dataSource[0][ComboxDictKey];
}

/**
 * 根据Key选中下拉框中的需要选中的某个值
 */
- (void)selectByKey:(NSString *)selectKey {
    if ([NSString isBlankString:selectKey]) return;
    
    // 选中值并调用代理方法
    for (NSDictionary *selectDict in self.dataSource) {
        if ([selectDict[ComboxDictKey] isEqualToString:selectKey]) {
            // 显示默认值
            self.contentLabel.text = selectDict[ComboxDictKey];
            
            // 调用代理方法
            if ([self.delegate respondsToSelector:@selector(dropLsitDidSelect:Combox:)]) {
                [self.delegate dropLsitDidSelect:selectDict Combox:self];
            }
            break;
        }
    }
}

/**
 * 根据Value选中下拉框中的需要选中的某个值
 */
- (void)selectByValue:(NSString *)selectValue {
    if ([NSString isBlankString:selectValue]) return;
    
    // 选中值并调用代理方法
    for (NSDictionary *selectDict in self.dataSource) {
        if ([selectDict[ComboxDictValue] isEqualToString:selectValue]) {
            // 显示默认值
            self.contentLabel.text = selectDict[ComboxDictKey];
            
            // 调用代理方法
            if ([self.delegate respondsToSelector:@selector(dropLsitDidSelect:Combox:)]) {
                [self.delegate dropLsitDidSelect:selectDict Combox:self];
            }
            break;
        }
    }
}

/**
 * 根据下标选中下拉框中的需要选中的某个值
 */
- (void)selectByIndex:(int)selectIndex {
    if (selectIndex > self.dataSource.count - 1) return;
    
    NSDictionary *selectDict = self.dataSource[selectIndex];
    
    // 显示默认值
    self.contentLabel.text = selectDict[ComboxDictKey];
    
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(dropLsitDidSelect:Combox:)]) {
        [self.delegate dropLsitDidSelect:selectDict Combox:self];
    }
}

/**
 * 获取选中下拉框下标
 */
- (int)dropSelectIndex {
    NSString *selectKey = self.contentLabel.text;
    int aryIdx = 0;
    for (NSDictionary *selectDict in self.dataSource) {
        if ([selectDict[ComboxDictKey] isEqualToString:selectKey]) {
            return aryIdx;
        }
        aryIdx++;
    }
    return -1;
}


#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"YComboBoxCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.dataSource[indexPath.row][ComboxDictKey];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取选择的数据
    NSDictionary *dropSelectDict = self.dataSource[indexPath.row];
    
    // 显示选中
    self.contentLabel.text = dropSelectDict[ComboxDictKey];
    
    // 隐藏TableVIew
    [self hideDropList];
    
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(dropLsitDidSelect:Combox:)]) {
        [self.delegate dropLsitDidSelect:dropSelectDict Combox:self];
    }
}

/**
 * 清空选择
 */
- (void)clearSelection{
    
    if (self.dropListAppear) {
        self.dropListAppear = NO;
        [self hideDropList];
    }
    
    self.contentLabel.text = @" ";
}

@end
