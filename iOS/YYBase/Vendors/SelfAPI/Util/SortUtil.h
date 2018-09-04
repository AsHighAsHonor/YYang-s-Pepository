//
//  SortUtil.h
//  排序工具类
//  ShopSteward
//
//  Created by YYang on 15/7/29.
//  Copyright (c) 2015年 ztesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortUtil : NSObject

#pragma mark - 使用冒泡排序对数值（int、float、double）类型的数组进行排序
/**
 *  使用冒泡排序对数值（int、float、double）类型的数组进行排序
 *
 *  @param numerArray 需要排序的数据
 */
+ (void)sortArrayWithNumberArray:(NSMutableArray *)numerArray;

@end
