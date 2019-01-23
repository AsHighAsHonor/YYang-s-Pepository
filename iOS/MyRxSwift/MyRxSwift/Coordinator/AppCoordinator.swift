//
//  AppCoordinator.swift
//  MyRxSwift
//
//  Created by YYang1 on 23/1/19.
//  Copyright © 2019 Drag. All rights reserved.
//

import UIKit


struct AppCoordinator {
    let window: UIWindow
    
    func lunch() {
        TabbarCoordinator(win: window).start()
    }
    
    
}
