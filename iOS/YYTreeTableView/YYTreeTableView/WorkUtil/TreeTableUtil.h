//
//  TreeTableUtil.h
//  GXMoblieOA
//
//  Created by YYang on 16/8/2.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TreeTableUtil : NSObject

/**
 *  @author YYang, 16-08-02 17:08:29
 *  移除该节点下所有子节点
 *
 *  思路:
     1.self.tempData(实际数据源)/self.nodesArr(所有的数据源)
     2.添加 --  选中节点为父节点(selectedNodes) 遍历nodesArr中所有的父id == 父节点 id 的所有节点  添加到 tempData 中
     3.删除  -- 选中节点为父节点(selectedNodes)  遍历tempData中所有深度(level)>父节点深度(level)的所有子节点  孙子节点
 *
 *  @param indexPath     indexPath description
 *  @param tempData      tempData description
 *  @param selectedNodes selectedNodes description
 */
+ (void)removeAllNodesAtParentNode : (NSIndexPath *)indexPath withTempData:(NSMutableArray *)tempData andSelectedNodes:(Nodes *)selectedNodes;

/**
 *  @author YYang, 16-08-02 17:08:09
 *
 *  添加该节点下所有子节点
 *
 *  @param indexPath     indexPath description
 *  @param nodesArr      nodesArr description
 *  @param tempData      tempData description
 *  @param selectedNodes selectedNodes description
 */
+ (void)addAllNodesAtParentNode: (NSIndexPath *)indexPath andNodes:(NSMutableArray *)nodesArr andTempData:(NSMutableArray *)tempData andSelectedNodes:(Nodes *)selectedNodes;

@end
