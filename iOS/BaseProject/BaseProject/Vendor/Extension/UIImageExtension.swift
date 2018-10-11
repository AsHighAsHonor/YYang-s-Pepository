//
//  UIImageExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

public extension UIImage{
    
    public class func imageWithColor(_ color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage? {
        
        var image: UIImage?
        
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        if let context: CGContext = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(color.cgColor)
            context.fill(rect)
            
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        return image
    }
    
    
}
