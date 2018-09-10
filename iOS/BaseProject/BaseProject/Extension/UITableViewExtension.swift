//
//  UITableViewExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

extension UITableView {
    public func y_relayoutHeaderView() -> Void {
        let height = tableHeaderView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var headerFrame = tableHeaderView?.frame
        headerFrame?.size.height = height!
        tableHeaderView?.frame = headerFrame!
    }
    
    
}
