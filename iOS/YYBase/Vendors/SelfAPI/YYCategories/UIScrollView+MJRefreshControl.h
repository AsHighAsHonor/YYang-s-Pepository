//
//  UITableView+MJRefreshControl.h
//  trader-ios
//
//  Created by YYang on 14/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MJRefreshControl)
-(void)hideRefreshFooter:(NSMutableArray *)models;
-(void)endRefresh;
@end
