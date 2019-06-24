//
//  UIApplictaionExtension.swift
//  
//
//  Created by YYang1 on 26/11/18.
//  
//

import UIKit

extension UIApplication{
    
    static func changeRootController(ctrl: UIViewController) {
        shared.delegate?.window?!.rootViewController = ctrl
    }
    
    static func currentCtrl() -> UIViewController? {
        let targetCtrl: UIViewController?
        var win = shared.keyWindow
        if win?.windowLevel != UIWindow.Level.normal  {
            let wins = shared.windows
            for w in wins {
                if w.windowLevel == .normal{
                    win = w
                    break
                }
            }
        }
        let frontView = win?.subviews.first
        let nextResponder = frontView?.next
        if nextResponder is UIViewController{
            targetCtrl = nextResponder as? UIViewController
        }else{
            targetCtrl = win?.rootViewController
        }
        return targetCtrl
    }
    
    static func currentView() -> UIView? {
        return shared.keyWindow?.subviews.last
    }
    
}

