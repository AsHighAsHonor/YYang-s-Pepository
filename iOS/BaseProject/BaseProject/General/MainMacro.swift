//
//  MainMacro.swift
//  BaseProject
//
//  Created by YYang on 9/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

 // MARK: - Log
func YYLog<T>(_ message: T, file: String = #file, lineNumber: Int = #line, method: String = #function) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber), \(method)]- \(message)")
    #endif
}


 // MARK: -UserDefault / NotificationCenter

public let STANDER_USERDEFAULT = UserDefaults.standard

public let NOTIFICATION_DEFAULT_CENTER = NotificationCenter.default


 // MARK: - Device
public let SCREEN_BOUNDS = UIScreen.main.bounds

public let SCREEN_WIDTH = UIScreen.main.bounds.size.width

public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

public let IS_IPHONE4 =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 960).equalTo((UIScreen.main.currentMode?.size)!) : false)

public let IS_IPHONE5 =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 1136).equalTo((UIScreen.main.currentMode?.size)!) : false)

public let IS_IPHONE6 =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 750, height: 1334).equalTo((UIScreen.main.currentMode?.size)!) : false)

public let IS_IPHONE6_PLUS =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false)

public let IS_IPHONE6_PLUS_SCALE =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2001).equalTo((UIScreen.main.currentMode?.size)!) : false)

public let IS_IPHONE_X =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)

public let TOP_AREA_HEIGHT = (IS_IPHONE_X ? 88 : 64)

public let STATUS_BAR_HEIGHT = (IS_IPHONE_X ? 44 : 20)

public let TABBAR_HEIGHT = (IS_IPHONE_X ? 83 : 49)

public let NAVIGATIONBAR_HEIGHT = 44

 // MARK: - Color

public let RGB_COLOR = {(r: Float, g: Float, b: Float) ->UIColor in
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha:1.0)
}

public let RGB_ACOLOR:((Float,Float,Float,Float) -> UIColor ) = { (r: Float, g: Float , b: Float , a: Float ) -> UIColor in
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
}

public let HEX_COLOR:((Int) -> UIColor) = { (rgbValue : Int) -> UIColor in
    return HEX_ACOLOR(rgbValue,1.0)
}

public let HEX_ACOLOR:((Int,Float) -> UIColor) = { (rgbValue : Int, alpha : Float) -> UIColor in
    return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha: CGFloat(alpha))
}

 // MARK: - Font

let FONT_14 = UIFont.systemFont(ofSize: 14)
let FONT_15 = UIFont.systemFont(ofSize: 15)
let FONT_16 = UIFont.systemFont(ofSize: 16)
let FONT_17 = UIFont.systemFont(ofSize: 17)
let FONT_18 = UIFont.systemFont(ofSize: 18)
let FONT_19 = UIFont.systemFont(ofSize: 19)
let FONT_20 = UIFont.systemFont(ofSize: 20)










