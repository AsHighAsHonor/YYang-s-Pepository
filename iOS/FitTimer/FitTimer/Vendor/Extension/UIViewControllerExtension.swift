//
//  UIViewControllerExtension.swift
//  FitTimer
//
//  Created by YYang1 on 12/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit
import JGProgressHUD
import NVActivityIndicatorView


 // MARK: - HUD
extension UIViewController {
    func toast(message: String?,delay: Int = 3) {
        HudManager.shared.showToast(message: message, in: view, delay: delay)
    }
    
    func hud(message: String = "", interactionType: JGProgressHUDInteractionType = .blockAllTouches) {
        HudManager.shared.showHud(message: message, in: view, interaction: interactionType)
    }
    
    func ringHud(message: String, totalSize: Float, readedSize: Float, detailText: String = "Progress: ", completionTitle: String = "Success!",completionDetail: String = "", interaction: JGProgressHUDInteractionType = .blockAllTouches) {
        HudManager.shared.showRingHud(message: message, in: view, totalSize: totalSize, readedSize: readedSize, detailText: detailText, completionTitle: completionTitle, completionDetail: completionDetail, interaction: interaction)
    }
    
    func indicator(color: UIColor = UIColor.gray, interaction: Bool = false, widthScale: CGFloat = 0.15, postionY: CGFloat = SCREEN_HEIGHT/2, type: NVActivityIndicatorType = .ballScaleMultiple) {
        HudManager.shared.showIndicator(in: view, color: color, interaction: interaction, widthScale: widthScale, postionY: postionY, type: type)
    }
    
    
    func hideHud(delay: Double? = 0) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: delay!)) {
            HudManager.shared.hideHud()
        }
    }
    
    func hideIndicator()  {
        HudManager.shared.hideIndicator(view: view)
    }
    
  
}


 // MARK: - NavigationStack
extension UIViewController{

    public func pop(delay: Double = 0, level: Int = 1, animated: Bool = true) {
        view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral:delay)) {
            _ = self.navigationController?.navPop(level: level, animated: animated)
        }
    }
    
    public func delayDismiss(delay: Double = 2.0, animated: Bool = true, completion: @escaping (()-> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: delay)) {
            self.dismiss(animated: animated, completion: completion)
        }
    }

    func popToCtrl(ctrlName: String){
        view.endEditing(true)
        _ = navigationController?.navPopToCtrl(ctrlName: ctrlName, animated: true)
    }
    
    func push(_ ctrl: UIViewController){
        view.endEditing(true)
        navigationController?.pushCtrl(ctrl, animated: true, hideBottomBar: true)
    }
    
    func replaceController(oldController:UIViewController,newController:UIViewController){
        guard oldController != newController else {
            return
        }
        addChild(newController)
        transition(from: oldController, to: newController, duration: 0.2, options:.curveLinear, animations: nil) {
            if $0{
                newController.didMove(toParent: self)
                oldController.willMove(toParent: nil)
                oldController.removeFromParent()
            }
        }
        
    }

}


 // MARK: - TabBar
extension UIViewController{
    public func hideTabBar(hidden: Bool = true) {
        tabBarController?.tabBar.isHidden = hidden
        hidesBottomBarWhenPushed = hidden
    }
    
    
}


extension UIViewController{
    
    public func setLeftItemImage(image: UIImage?, imageInsets: UIEdgeInsets? = UIEdgeInsets.zero, target: Any? = nil, action: Selector? = nil)  {
        let item = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .done, target: target, action:action)
        item.imageInsets = imageInsets!
        navigationItem.setLeftBarButtonItems([item], animated: true)
    }
    
    public func setRightItemImage(image: UIImage?, imageInsets: UIEdgeInsets = UIEdgeInsets.zero, target: Any? = nil, action: Selector? = nil) {
        let itemSearch = UIBarButtonItem(image: image, style: .plain, target: target, action:action)
        itemSearch.imageInsets = imageInsets
        navigationItem.setRightBarButtonItems([itemSearch], animated: true)
    }
    
    public func setRightItemTitle(title: String?, target: Any? = nil, action: Selector? = nil) {
        let itemSearch = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.setRightBarButtonItems([itemSearch], animated: true)
    }
    
    public func setLeftItemTitle(title: String?, target: Any? = nil, action: Selector? = nil) {
        let itemSearch = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.setLeftBarButtonItems([itemSearch], animated: true)
    }
    
}

