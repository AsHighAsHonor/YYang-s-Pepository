//
//  BundleExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


 // MARK: - Load
public extension Bundle{
    
    public static func y_loadNib(name: String, owner: Any?) -> Any? {
        return self.main.loadNibNamed(name, owner: owner, options: nil)?.first
    }
    
    public static func y_pathForPlist(name: String) ->String?{
        return main.path(forResource: name, ofType: "plist")
    }
    
    public static func y_mainResources(type: String) ->[String]?{
        return main.paths(forResourcesOfType: type, inDirectory: nil)
    }
    
    
}




