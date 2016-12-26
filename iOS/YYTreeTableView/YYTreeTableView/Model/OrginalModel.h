//
//  OrginalModel.h
//  TreeTableView
//
//  Created by YYang on 22/12/2016.
//  Copyright © 2016 yixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrginalModel : NSObject
@property (nonatomic, copy) NSString *is_end;

@property (nonatomic, copy) NSString *org_id;

@property (nonatomic, copy) NSString *org_level;

@property (nonatomic, copy) NSString *display_id;

@property (nonatomic, copy) NSString *short_name;

@property (nonatomic, copy) NSString *org_name;

@property (nonatomic, copy) NSString *parent_org_id;

@property (nonatomic , assign,getter=isExpand) BOOL expand;//该节点是否处于展开状态

@property (nonatomic , assign,getter=isDisplay) BOOL display;//该节点是否展示

@property(nonatomic,assign,getter=isChecked)BOOL checked;//该节点的checkbox 状态


@end
