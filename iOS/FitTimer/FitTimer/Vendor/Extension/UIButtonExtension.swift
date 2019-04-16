//
//  UIButtonExtension.swift
//  FitTimer
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

struct EnlargeEdgeAssociatedKeys {
    static var topNameKey: UInt8 = 0
    static var rightNameKey: UInt8 = 1
    static var bottomNameKey: UInt8 = 2
    static var leftNameKey: UInt8 = 3
}




public extension UIButton{
    
    public func set(font: UIFont? = nil, textColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.white, text: String? = nil, image: UIImage? = nil,  state: UIControl.State = .normal){
        setTitle(text, for: state)
        titleLabel?.font = font
        titleLabel?.textColor = textColor
        tintColor = textColor
        setImage(image, for: state)
        setBackgroundImage(UIImage.imageWithColor(backgroundColor), for: state)
    }

}

extension UIButton{
    
    public func setEnlargeEdge(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        objc_setAssociatedObject(self, &EnlargeEdgeAssociatedKeys.topNameKey, top, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &EnlargeEdgeAssociatedKeys.rightNameKey, right, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &EnlargeEdgeAssociatedKeys.bottomNameKey, bottom, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &EnlargeEdgeAssociatedKeys.leftNameKey, left, .OBJC_ASSOCIATION_COPY_NONATOMIC);
    }

    private func enlargedRect() -> CGRect {
        let topEdge = objc_getAssociatedObject(self, &EnlargeEdgeAssociatedKeys.topNameKey) as? CGFloat
        let leftEdge = objc_getAssociatedObject(self, &EnlargeEdgeAssociatedKeys.leftNameKey)as? CGFloat
        let bottomEdge = objc_getAssociatedObject(self, &EnlargeEdgeAssociatedKeys.bottomNameKey)as? CGFloat
        let rightEdge = objc_getAssociatedObject(self, &EnlargeEdgeAssociatedKeys.rightNameKey)as? CGFloat
        
        if let top = topEdge, let left = leftEdge, let right = rightEdge, let bottom = bottomEdge {
            return CGRect(x: bounds.origin.x - left, y: bounds.origin.y - top, width: bounds.size.width + left + right, height: bounds.size.height + top + bottom)
        }else{
            return bounds
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = enlargedRect()
        if rect.equalTo(bounds) {
            return super.point(inside: point, with: event)
        }else{
            return rect.contains(point)
        }
    }
    
  
    
    
}
