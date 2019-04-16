//
//  MainMacro.swift
//  FitTimer
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

public let IS_IPHONE4 =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 960).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE5 =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 1136).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE6 =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 750, height: 1334).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE6_PLUS =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE6_PLUS_SCALE =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2001).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE_X =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE_Xr =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE_Xs =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false

public let IS_IPHONE_Xs_Max =  UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!) : false

public let TOP_AREA_HEIGHT: CGFloat = (IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 88 : 64

public let STATUS_BAR_HEIGHT: CGFloat = (IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 44 : 20

public let TABBAR_HEIGHT: CGFloat = (IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 83 : 49


 // MARK: - Font

let FONT_14 = UIFont.systemFont(ofSize: 14)
let FONT_15 = UIFont.systemFont(ofSize: 15)
let FONT_16 = UIFont.systemFont(ofSize: 16)
let FONT_17 = UIFont.systemFont(ofSize: 17)
let FONT_18 = UIFont.systemFont(ofSize: 18)
let FONT_19 = UIFont.systemFont(ofSize: 19)
let FONT_20 = UIFont.systemFont(ofSize: 20)

let FONTAWESOME = "FontAwesome"

func ICOMOON(_ size: CGFloat) -> UIFont {
    return UIFont(name: "icomoon", size: size)!
}

 // MARK: - Color

let FB_BLUE = UIColor(hexString: "#3B5998")
let CELL_CEPARATOR_COLOR = UIColor(hexString: "#C8C7CC")


// MARK: - Icon

let ICON_CHECKED = "\u{f058}"
let ICON_UNCHECKED =  "\u{f1db}"
let ICON_CELL_ARROW =  "\u{f105}"
let ICON_CELL_PLUS =  "\u{f067}"
let ICON_STAR = "\u{f005}"
let ICON_TROPYCUP = "\u{f091}"
let ICON_GEAR = "\u{f013}"
let ICON_DETAIL =  "\u{f05a}"
let ICON_OUT =  "\u{f08b}"
let ICON_SEARCH = "\u{e6bb}"











