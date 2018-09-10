//
//  UIButtonExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

public extension UIButton{
    func y_setBackgroundColor(color: UIColor, state: UIControlState) -> Void {
        setBackgroundImage(UIImage.imageWithColor(color), for: state)
    }
    
}
