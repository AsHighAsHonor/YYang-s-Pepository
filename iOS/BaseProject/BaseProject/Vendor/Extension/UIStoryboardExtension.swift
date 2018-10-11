//
//  UIStoryboardExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    public static func loadController(ctrlName: String, storyboard: String) -> UIViewController {
        
        let sb = UIStoryboard.init(name: storyboard, bundle: nil)
        return sb.instantiateViewController(withIdentifier: ctrlName)
    }
 
    
}
