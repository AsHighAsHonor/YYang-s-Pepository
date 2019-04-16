//
//  BundleExtension.swift
//  FitTimer
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


 // MARK: - Load
public extension Bundle{
    
    public static func loadNib(name: String, owner: Any?) -> Any? {
        return self.main.loadNibNamed(name, owner: owner, options: nil)?.first
    }
    
    public static func pathForPlist(name: String) ->String?{
        return main.path(forResource: name, ofType: "plist")
    }
    
    public static func mainResources(type: String) ->[String]?{
        return main.paths(forResourcesOfType: type, inDirectory: nil)
    }
    
    
}




