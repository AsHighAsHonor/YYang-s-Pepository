//
//  UIViewControllerExtension.swift
//  BaseProject
//
//  Created by YYang1 on 12/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit
import JGProgressHUD
import NVActivityIndicatorView


 // MARK: - HUD
extension UIViewController {
    func toast(message: String,delay: Int = 3) {
        HudManager.shared.showToast(message: message, in: view, delay: delay)
    }
    
    func hud(message: String = "", interactionType: JGProgressHUDInteractionType = .blockAllTouches) {
        HudManager.shared.showHud(message: message, in: view, interaction: interactionType)
    }
    
    func ringHud(message: String, totalSize: Float, readedSize: Float, detailText: String = "Progress: ", completionTitle: String = "Success!",completionDetail: String = "", interaction: JGProgressHUDInteractionType = .blockAllTouches) {
        HudManager.shared.showRingHud(message: message, in: view, totalSize: totalSize, readedSize: readedSize, detailText: detailText, completionTitle: completionTitle, completionDetail: completionDetail, interaction: interaction)
    }
    
    func indicator(color: UIColor = UIColor.blue, interaction: Bool = false, widthScale: CGFloat = 0.15, postionY: CGFloat = 36, type: NVActivityIndicatorType = .ballScaleMultiple) {
        HudManager.shared.showIndicator(in: view, color: color, interaction: interaction, widthScale: widthScale, postionY: postionY, type: type)
    }
    
    
    func hideHud() {
        HudManager.shared.hideHud()
        HudManager.shared.hideIndicator(view: view)
    }
    
    func hideIndicator()  {
        HudManager.shared.hideIndicator(view: view)
    }
    
  
}


 // MARK: - NavigationStack
extension UIViewController{

    public func y_pop(delay: Double = 0, level: Int = 1, animated: Bool = true) {
        view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral:delay)) {
            _ = self.navigationController?.y_NavPop(level: level, animated: animated)
        }
    }
    
    public func y_delayDismiss(delay: Double = 2.0, animated: Bool = true, completion: @escaping (()-> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: delay)) {
            self.dismiss(animated: animated, completion: completion)
        }
    }

    func y_popToCtrl(ctrlName: String){
        view.endEditing(true)
        _ = navigationController?.y_NavPopToCtrl(ctrlName: ctrlName, animated: true)
    }

}


 // MARK: - TabBar
extension UIViewController{
    public func hideTabBar(hidden: Bool = true) {
        tabBarController?.tabBar.isHidden = hidden
        hidesBottomBarWhenPushed = hidden
    }
    
    
}

 // MARK: - NavigationBar
extension UIViewController{
    
    public func hideNavigationBarUnderLine(hidden: Bool = true) {
        navigationController?.navigationBar.setBackgroundImage((hidden ? UIImage(): nil), for: .default)
        navigationController?.navigationBar.shadowImage = (hidden ? UIImage(): nil)
    }
    
    func setNavigationBarUnderlineColor(color: UIColor) {
        if let navBar = navigationController?.navigationBar {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage.y_imageWithColor(color)
        }
    }
    
}
