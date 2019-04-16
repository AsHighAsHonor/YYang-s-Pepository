//
//  UIStoryboardExtension.swift
//  FitTimer
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}


public extension UIStoryboard {
    public static func loadController(ctrlName: String, storyboard: String) -> UIViewController {
        
        let sb = UIStoryboard.init(name: storyboard, bundle: nil)
        return sb.instantiateViewController(withIdentifier: ctrlName)
    }
 
    
}
