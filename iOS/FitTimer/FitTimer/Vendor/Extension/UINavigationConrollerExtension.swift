//
//  UINavigationConrollerExtension.swift
//  FitTimer
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


 // MARK: - NavigationBar/TabBar
extension UINavigationController{
    
    open override var childForStatusBarStyle : UIViewController{
        get{
            return topViewController ?? UIViewController()
        }
    }

   public func translucentNavigationbar() -> Void {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.clear), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
    
    public func displayNavigationbar() -> Void {
        navigationBar.isTranslucent = false
    }
    
    public func pushCtrl(_ viewController: UIViewController, animated: Bool = true , hideBottomBar: Bool = false){
        viewController.hidesBottomBarWhenPushed = hideBottomBar
        pushViewController(viewController, animated: animated)
    }
    
    public func hideNavigationBarUnderLine(hidden: Bool = true) {
        navigationBar.setBackgroundImage((hidden ? UIImage(): nil), for: .default)
        navigationBar.shadowImage = (hidden ? UIImage(): nil)
    }
    
    public func setNavigationBarUnderlineColor(color: UIColor) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage.imageWithColor(color)
    }

    
    
}


 // MARK: - UINavigationStackManager

extension UINavigationController{
    
    public func navPop(level: Int, animated: Bool)->([UIViewController]?){
        let ctrlsCount = viewControllers.count
        if ctrlsCount > level {
            let viewCtrl = viewControllers[(ctrlsCount - level - 1)]
            return popToViewController(viewCtrl, animated: animated)
        } else {
            return popToRootViewController(animated: animated)
        }
    }
    
    public func navFindCtrl(ctrlName: String) -> UIViewController? {
        if let tagetCtrl = NSClassFromString(UIDevice.bundleName + "." + ctrlName) {
            for ctrl in viewControllers {
                if(ctrl.isKind(of: tagetCtrl)){
                    return ctrl
                }
            }
            return nil
        }
        return nil
    }
    
    public func navPopToCtrl(ctrlName: String, animated: Bool = true ) -> [UIViewController]? {
        if let targetCtrl = navFindCtrl(ctrlName: ctrlName) {
            return popToViewController(targetCtrl, animated: animated)
        }else{
            return nil
        }
    }
    
}
