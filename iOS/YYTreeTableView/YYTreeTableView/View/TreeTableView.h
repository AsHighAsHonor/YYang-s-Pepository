//
//  TreeTableView.h
//  GXMoblieOA
//
//  Created by YYang on 16/3/30.
//  Copyright © 2016年 YYang. All rights reserved.
//


#import <UIKit/UIKit.h>
@class TreeTableView;
@class Node;
@class OrginalModel;


@protocol ThreeTableViewDelegate <NSObject>

@optional
/**
 *
 *  点击 cell 的代理
 *
 *  @param tableView 点击的tableView
 *  @param indexPath indexPath description
 *  @param node      点击的那个节点
 */
- (void)threeTableView:( TreeTableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath WithParentNode:(Node *)node;

/**
 *
 *  点击了 cell 上的 checkBox
 *
 *  @param tableView TreeTableView
 *  @param node      点击的节点
 *  @param indexPath  indexPath
 */
- (void)threeTableView:(TreeTableView *)tableView checkBoxClickedWithParentNode:(Node *)node atIndexPath:(NSIndexPath *)indexPath;

/**
 *  @author MonW
 *
 *  点击 cell 上的 foldBtn
 *
 *  @param tableView  TreeTableView
 *  @param indexPath  indexPath
 *  @param parentNode 点击的那个节点
 */
- (void)threeTableView:(TreeTableView *)tableView foldBtnClickedAtIndexPath:(NSIndexPath *)indexPath parentNode:(Node *)parentNode;

@end

@interface TreeTableView : UITableView
@property(nonatomic,assign) id <ThreeTableViewDelegate>myDelegate;

/**
 原始模型数据
 */
@property(nonatomic,strong)NSMutableArray<OrginalModel*> * originDatas;
/**
 *
 *  生成新的树节点数据
 *
 *  @param data 节点原始数据
 */
-(void)generateDataWithData:(NSMutableArray *)data ;

-(instancetype)initWithDataSource:(NSMutableArray *)dataSource;

@end
