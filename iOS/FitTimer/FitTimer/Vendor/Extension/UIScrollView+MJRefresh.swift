//
//  UIScrollView+MJRefresh.swift
//  RxMJ
//
//  Created by YYang on 28/10/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


extension UIScrollView{
    
    public func addRefreshHeaderAndFooter()  {
        addRefreshHeader()
        addRefreshFooter()
    }
    
    
    public func addRefreshHeader(hideTime: Bool? = true , hideState: Bool? = true)  {
        let mjHeader = MJRefreshNormalHeader()
        mjHeader.lastUpdatedTimeLabel.isHidden = hideTime!
        mjHeader.stateLabel.isHidden = hideState!
        mj_header = mjHeader
    }
    
    
    public func addRefreshFooter()  {
        let mjFooter = MJRefreshBackNormalFooter()
        mj_footer = mjFooter
    }
    

}
