//
//  ComboBox.h
//  DropdownListButton
//
//  Created by Mon on 10/16/15.
//  Copyright © 2015 Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ComboxDictKey;
extern NSString *const ComboxDictValue;

@class ComboBox;

@protocol ComboBoxDelegate <NSObject>

@required
- (void)dropLsitDidSelect:(NSDictionary *)selectDict Combox:(ComboBox *)combox;

@end

@interface ComboBox : UIView

//内容
@property (nonatomic, strong) UILabel *contentLabel;

//指示箭头
@property (nonatomic, strong) UIImageView *arrowImageView;

//按钮
@property (nonatomic, strong) UIButton *mainButton;

//列表是否呈现
@property (nonatomic, assign, getter=isDropListAppear) BOOL dropListAppear;

/**
 *  调用ComboBox的ViewController
 */
@property (nonatomic, strong) UIViewController *sender;

@property (nonatomic, strong) UIButton *hideBtn;
/**
 *  代理
 */
@property (nonatomic, assign) id <ComboBoxDelegate> delegate;

/**
 * 数据源
 */
@property (nonatomic, copy) NSArray *dataSource;

/**
 * 是否启用
 */
@property (nonatomic, assign, getter=isEnable) BOOL enable;

/**
 * 下拉列表
 */
@property (nonatomic, strong) UITableView *dropList;

/**
 * 启用时边框颜色
 */
@property (nonatomic, strong) UIColor *enableBorderColor;

/**
 * 禁用时边框颜色
 */
@property (nonatomic, strong) UIColor *disableBorderColor;

/**
 * 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource sender:(UIViewController *)sender;

/**
 * 显示下拉列表
 */
- (void)showDropList;

/**
 * 隐藏下拉列表
 */
- (void)hideDropList;

/**
 * 重新加载下拉列表数据
 */
- (void)reload;

/**
 * 根据Key选中下拉框中的需要选中的某个值
 */
- (void)selectByKey:(NSString *)selectKey;

/**
 * 根据Value选中下拉框中的需要选中的某个值
 */
- (void)selectByValue:(NSString *)selectValue;

/**
 * 根据下标选中下拉框中的需要选中的某个值
 */
- (void)selectByIndex:(int)selectIndex;

/**
 * 获取选中下拉框下标
 */
- (int)dropSelectIndex;

/**
 * 清空选择
 */
- (void)clearSelection;

@end
