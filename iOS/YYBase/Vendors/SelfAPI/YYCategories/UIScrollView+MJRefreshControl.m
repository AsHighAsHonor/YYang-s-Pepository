//
//  UITableView+MJRefreshControl.m
//  trader-ios
//
//  Created by YYang on 14/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UIScrollView+MJRefreshControl.h"

@implementation UIScrollView (MJRefreshControl)

-(void)endRefresh{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}

-(void)hideRefreshFooter:(NSMutableArray *)models{
    if ([NSMutableArray isEmptyArray:models]) {
        [self.mj_footer setHidden:YES];
    }else{
        [self.mj_footer setHidden:NO];
    }
}

-(void)hideFooterAndHeader{

}

@end
