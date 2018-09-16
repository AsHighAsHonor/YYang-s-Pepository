//
//  UINavigationConrollerExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


 // MARK: - NavigationBar
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


 // MARK: - UINavigationStackManager

extension UINavigationController{
    
    public func y_NavPop(level: Int, animated: Bool)->([UIViewController]?){
        let ctrlsCount = viewControllers.count
        if ctrlsCount > level {
            let viewCtrl = viewControllers[(ctrlsCount - level - 1)]
            return popToViewController(viewCtrl, animated: animated)
        } else {
            return popToRootViewController(animated: animated)
        }
    }
    
    public func y_NavFindCtrl(ctrlName: String) -> UIViewController? {
        if let tagetCtrl = NSClassFromString(UIDevice.y_bundleName + "." + ctrlName) {
            for ctrl in viewControllers {
                if(ctrl.isKind(of: tagetCtrl)){
                    return ctrl
                }
            }
            return nil
        }
        return nil
    }
    
    public func y_NavPopToCtrl(ctrlName: String, animated: Bool = true ) -> [UIViewController]? {
        if let targetCtrl = y_NavFindCtrl(ctrlName: ctrlName) {
            return popToViewController(targetCtrl, animated: animated)
        }else{
            return nil
        }
    }
    
}
