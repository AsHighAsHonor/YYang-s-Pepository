//
//  Node.m
//  GXMoblieOA
//
//  Created by YYang on 16/3/30.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import "Node.h"

@implementation Node
- (instancetype)initWithParentId : (NSString *)parentId nodeId : (NSString*)nodeId name : (NSString *)name depth : (NSString*)depth expand : (BOOL)expand andCheckStatus:(CheckStatus)checkStatus andIsEnd:(NSString *)isEnd
{
    self = [super init];
    if(self)
    {
        self.parentId = parentId;
        self.nodeId = nodeId;
        self.name = name;
        self.depth = depth;
        self.isExpand = expand;
        self.checkStatus = checkStatus;
        self.isEnd = isEnd;
        self.isSelected = NO;
    }
    return self;
}
//改。。
- (void)setIsExpand:(BOOL)isExpand{
    _isExpand = isExpand;
}

@end
