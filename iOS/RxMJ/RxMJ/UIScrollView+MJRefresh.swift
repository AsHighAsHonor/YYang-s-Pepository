//
//  UIScrollView+MJRefresh.swift
//  RxMJ
//
//  Created by YYang on 28/10/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


extension UIScrollView{
    
    public func setUpRefreshHeaderAndFooter()  {
        let mjHeader = MJRefreshNormalHeader()
        let mjFooter = MJRefreshBackNormalFooter()
        mjHeader.lastUpdatedTimeLabel.isHidden = true
        
        mj_header = mjHeader
        mj_footer = mjFooter
    }

}
