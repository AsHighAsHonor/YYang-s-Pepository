//
//  BaseTabBar.swift
//  BaseProject
//
//  Created by YYang1 on 13/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


class BaseTabBar: UITabBar {

    lazy var centerBtn : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
        btn.titleLabel?.text = "PLUS"
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerBtn.tintColor = UIColor.black
        self.addSubview(centerBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let ctrls = []
        
        for view in self.subviews{
            if(view.isKind(of: NSClassFromString(UIDevice.y_bundleName + "UITabBarButton"))){
                ctrls.append(view)
            }
        }
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    


}
