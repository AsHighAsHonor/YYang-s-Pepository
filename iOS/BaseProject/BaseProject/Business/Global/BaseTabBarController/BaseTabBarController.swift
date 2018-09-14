//
//  BaseTabBarController.swift
//  BaseProject
//
//  Created by YYang1 on 13/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBar.backgroundColor = UIColor(hexString: "#D1E5F0")
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor.white
        setValue(BaseTabBar(), forKey: "tabBar")
        delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        YYLog(tabBarController.selectedIndex)
        return true
    }
    


}
