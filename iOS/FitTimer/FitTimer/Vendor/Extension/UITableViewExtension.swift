//
//  UITableViewExtension.swift
//  FitTimer
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

extension UITableView {
    public func relayoutHeaderView(){
        let height = tableHeaderView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var headerFrame = tableHeaderView?.frame
        headerFrame?.size.height = height!
        tableHeaderView?.frame = headerFrame!
    }
    
    func addTableHeaderView(header: UIView, frame: CGRect = .zero){
        let headerView: UIView!
        if frame == .zero {
            headerView = UIView(frame: header.frame)
        }else{
            headerView = UIView(frame: frame)
        }
        headerView.addSubview(header)
        header.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableHeaderView = headerView
    }
    
    func addTableFooterView(footer: UIView, frame: CGRect = .zero){
        let footerView: UIView!
        if frame == .zero {
            footerView = UIView(frame: footer.frame)
        }else{
            footerView = UIView(frame: frame)
        }
        footerView.addSubview(footer)
        footer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableFooterView = footerView
    }
    
    
}
