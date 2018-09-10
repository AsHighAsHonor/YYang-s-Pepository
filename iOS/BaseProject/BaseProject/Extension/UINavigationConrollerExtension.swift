//
//  UINavigationConrollerExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


extension UINavigationController{
    
    open override var childViewControllerForStatusBarStyle : UIViewController{
        get{
            return topViewController!
        }
    }

   public func y_translucentNavigationbar() -> Void {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage.y_imageWithColor(UIColor.clear), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
    
    public func y_displayNavigationbar() -> Void {
        navigationBar.isTranslucent = false
    }
    
    
}
