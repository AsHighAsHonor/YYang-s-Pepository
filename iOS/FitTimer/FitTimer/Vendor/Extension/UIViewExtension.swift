//
//  UIViewExtension.swift
//  FitTimer
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


 // MARK: - Event
extension UIView{
    
    public func addTapGesture(target: Any, selector: Selector, enableInteraction: Bool = true) -> Void {
        let tap = UITapGestureRecognizer(target: target, action: selector)
        tap.numberOfTapsRequired = 1
        isUserInteractionEnabled = enableInteraction
        addGestureRecognizer(tap)
    }
}


extension UIView{
    public func setCorner(radius: CGFloat = 0, borderColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0) {
        layer.cornerRadius = radius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
    }
    
}
