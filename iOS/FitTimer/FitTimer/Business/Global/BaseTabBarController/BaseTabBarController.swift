//
//  BaseTabBarController.swift
//  FitTimer
//
//  Created by YYang1 on 13/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tabBar.backgroundColor = UIColor(hexString: "#D1E5F0")
//        tabBar.backgroundImage = UIImage()
//        tabBar.tintColor = UIColor.black
//        tabBar.unselectedItemTintColor = UIColor.white
        let tab = BaseTabBar()
        tab.baseTabBarDelegate = self
        setValue(tab, forKey: "tabBar")
        delegate = self
    }

}



 // MARK: - DelegateMethod
extension BaseTabBarController: BaseTabBarDelegate, UITabBarControllerDelegate{
    func BaseTabBarCenterBtnClicked(button: UIButton) {
        YYLog(button)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        YYLog(tabBarController.selectedIndex)
        return true
    }

    
    
}
