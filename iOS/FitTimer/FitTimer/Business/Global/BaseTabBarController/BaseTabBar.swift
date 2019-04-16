//
//  BaseTabBar.swift
//  FitTimer
//
//  Created by YYang1 on 13/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit



//只有类才能实现的protocol
//有一种场景，protocol作为delegate，需要使用weak关键字修饰的时候，需要指定delegate的类型为ptotocol型，这个ptotocol需要添加class修饰符，比如下面的这个protocol，因为类类型的对象才有引用计数，才有weak的概念，没有引用计数的struct型是没有weak概念的
protocol BaseTabBarDelegate: class{
    func BaseTabBarCenterBtnClicked(button: UIButton)
}

class BaseTabBar: UITabBar {
    
    private let centerBtnWidth: CGFloat = 80
    private let centerBtnHeight: CGFloat = 60
    weak var baseTabBarDelegate: BaseTabBarDelegate?
    
    

    private lazy var centerBtn : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: centerBtnWidth, height: centerBtnHeight))
        btn.backgroundColor = .red
        btn.titleLabel?.text = "PLUS"
//        btn.addTarget(self, action: Selector(("centerBtnClicked")), for:.touchUpInside)    // swift 中的 target-action2种写法   1.Selector通过字符串 2. 使用#selector
        btn.addTarget(self, action: #selector(centerBtnClicked(btn:)) , for:.touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerBtn.tintColor = UIColor.black
        self.addSubview(centerBtn)
        
        backgroundColor = UIColor(hexString: "#D1E5F0")
        backgroundImage = UIImage()
        tintColor = UIColor.black
        unselectedItemTintColor = UIColor.white
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
        bringSubviewToFront(centerBtn)
        
    }
    
    @objc private func centerBtnClicked(btn: UIButton) {
        baseTabBarDelegate?.BaseTabBarCenterBtnClicked(button: btn)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    


}
