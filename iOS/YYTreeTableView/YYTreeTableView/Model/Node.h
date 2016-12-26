//
//  Node.h
//  GXMoblieOA
//
//  Created by YYang on 16/3/30.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
@property (nonatomic , strong) NSString *parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , strong) NSString *nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称

@property (nonatomic , strong) NSString *depth;//该节点的深度

@property(nonatomic,strong)NSString *isEnd;


@property (nonatomic , assign,getter=isExpand) BOOL expand;//该节点是否处于展开状态

@property(nonatomic,assign,getter=isChecked)BOOL checked;//该节点的checkbox 状态


/**
 *快速实例化该对象模型
 */
- (instancetype)initWithParentId : (NSString *)parentId nodeId : (NSString*)nodeId name : (NSString *)name depth : (NSString*)depth expand : (BOOL)expand andCheckStatus:(BOOL)checkStatus andIsEnd:(NSString *)isEnd;

@end
