//
//  TreeTableUtil.m
//  GXMoblieOA
//
//  Created by YYang on 16/8/2.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import "TreeTableUtil.h"


@implementation TreeTableUtil

+ (void)removeAllNodesAtParentNode : (NSIndexPath *)indexPath withTempData:(NSMutableArray *)tempData andSelectedNodes:(Nodes *)selectedNodes{
    NSUInteger startPosition = indexPath.row;
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<tempData.count; i++) {
        Nodes *depModel = [tempData objectAtIndex:i];
        endPosition++;
        if (depModel.level.intValue <= selectedNodes.level.intValue) {
            break;
        }
        if(endPosition == tempData.count-1){
            endPosition++;
            break;
        }
    }
    if (endPosition>startPosition) {
        [tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
}



+ (void)addAllNodesAtParentNode: (NSIndexPath *)indexPath andNodes:(NSMutableArray *)nodesArr andTempData:(NSMutableArray *)tempData andSelectedNodes:(Nodes *)selectedNodes{
    
    NSUInteger startPosition = indexPath.row+1;
    NSUInteger endPosition = startPosition;
    
    for (int i=0; i<nodesArr.count; i++) {
        Nodes *node = [nodesArr objectAtIndex:i];
        if ([node.pId isEqualToString:selectedNodes.selfId]) {
            node.isExpand = NO;
            [tempData insertObject:node atIndex:endPosition];
            endPosition++;
        }
    }
    
}

@end
