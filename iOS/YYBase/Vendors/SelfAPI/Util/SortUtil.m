//
//  SortUtil.m
//  排序工具类
//  ShopSteward
//
//  Created by YYang on 15/7/29.
//  Copyright (c) 2015年 ztesoft. All rights reserved.
//

#import "SortUtil.h"

@implementation SortUtil

#pragma mark - 使用冒泡排序对数值（int、float、double）类型的数组进行排序
/**
 *  使用冒泡排序对数值（int、float、double）类型的数组进行排序
 *
 *  @param numerArray 需要排序的数据
 */
+ (void)sortArrayWithNumberArray:(NSMutableArray *)numerArray {
    // 冒泡排序
    NSNumber *temp, *before,*end;
    NSString *tempStr,*beforeStr,*endStr;
    
    int count = numerArray.count;
    
    for (int i = 0; i < count - 1; ++i) {
        for (int j = 0; j < count - 1; ++j) {
            before = [numerArray objectAtIndex:j];
            end = [numerArray objectAtIndex:j + 1];
            
            beforeStr = [numerArray objectAtIndex:j];
            endStr = [numerArray objectAtIndex:j + 1];
            
            if ([before doubleValue] < [end doubleValue]) {
                temp = end;
                end = before;
                before = temp;
                
                [numerArray removeObjectAtIndex:j];
                [numerArray insertObject:before atIndex:j];
                
                [numerArray removeObjectAtIndex:j + 1];
                [numerArray insertObject:end atIndex:j + 1];
                
                tempStr = endStr;
                endStr = beforeStr;
                beforeStr = tempStr;
                
                [numerArray removeObjectAtIndex:j];
                [numerArray insertObject:beforeStr atIndex:j];
                
                [numerArray removeObjectAtIndex:j + 1];
                [numerArray insertObject:endStr atIndex:j + 1];
            }
        }
    }
}

@end
