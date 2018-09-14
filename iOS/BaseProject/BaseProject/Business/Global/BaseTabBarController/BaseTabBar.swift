//
//  BaseTabBar.swift
//  BaseProject
//
//  Created by YYang1 on 13/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


class BaseTabBar: UITabBar {
    
    let centerBtnWidth: CGFloat = 80
    let centerBtnHeight: CGFloat = 60
    
    

    lazy var centerBtn : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: centerBtnWidth, height: centerBtnHeight))
        btn.y_setBackgroundColor(color: UIColor.red, state: .normal)
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
        var tabBarButtons = [UIView]()
        
        for view in self.subviews{
            if view .isKind(of: NSClassFromString("UITabBarButton")!){
                tabBarButtons.append(view)
            }
        }
        

        
        let barWidth = bounds.size.width
        let barHeight = bounds.size.height
        centerBtn.center = CGPoint(x: barWidth/2, y: barHeight - centerBtnHeight/2)
        let barItemWidth = (barWidth - centerBtnWidth) / CGFloat(tabBarButtons.count)
        
        for idx in 0..<tabBarButtons.count{
            let view = tabBarButtons[idx]
            var frame = view.frame
            
            if idx >= tabBarButtons.count/2{
                frame.origin.x = CGFloat(idx) * barItemWidth + centerBtnWidth
            }else{
                frame.origin.x = CGFloat(idx) * barItemWidth
            }
            frame.size.width = barItemWidth
            view.frame = frame
        }
        bringSubview(toFront: centerBtn)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    


}
