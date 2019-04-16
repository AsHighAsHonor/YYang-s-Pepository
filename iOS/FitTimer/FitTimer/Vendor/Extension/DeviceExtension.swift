//
//  DeviceExtension.swift
//  FitTimer
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


public extension UIDevice{
    
    public static var version: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var build: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    public static var identifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    public static var bundleName: String{
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        return bundleName.replacingOccurrences(of: "-", with: "_")
    }
    
    public static var currentLan: String {
        return "\(String(describing: Locale.preferredLanguages.first))"
    }
    
    public static var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let str = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        return str;
    }
    
}
