//
//  DeviceExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


public extension UIDevice{
    
    public static var y_version: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var y_build: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    public static var y_identifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    public static var y_bundleName: String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    public static var y_currentLan: String {
        return "\(String(describing: Locale.preferredLanguages.first))"
    }
    
    public static var y_deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let str = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        return str;
    }
    
}
