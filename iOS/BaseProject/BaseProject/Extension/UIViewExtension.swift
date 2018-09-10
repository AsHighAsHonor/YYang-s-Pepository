//
//  UIViewExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


 // MARK: - Event
extension UIView{
    
    public func y_addTapGesture(target: Any, selector: Selector, enableInteraction: Bool = true) -> Void {
        let tap = UITapGestureRecognizer(target: tag, action: selector)
        tap.numberOfTapsRequired = 1
        isUserInteractionEnabled = enableInteraction
        self.addGestureRecognizer(tap)
    }
}


extension UIView{
    public func y_setCornerRadius(_ v: CGFloat) {
        layer.cornerRadius = v
        layer.masksToBounds = true
    }
    
}
