//
//  TabbarCoordinator.swift
//  MyRxSwift
//
//  Created by YYang1 on 23/1/19.
//  Copyright © 2019 Drag. All rights reserved.
//

import UIKit



struct TabbarCoordinator {
    var win: UIWindow
    
    func start() {
        let tab = MyTabBarController()
       
        let newsNav = FirstCoordinator().navigationController
        let newsItem = UITabBarItem(title: "first", image: nil, tag: 0)
        newsNav.tabBarItem = newsItem
        
        
        let workoutNav = SecondCoordinator().navigationController
        let workoutItem = UITabBarItem(title: "Second", image: nil, tag: 1)
        workoutNav.tabBarItem = workoutItem
        
        let nutritionNav = ThirdCoordinator().navigationController
        let nutritionItem = UITabBarItem(title: "Third", image: nil, tag: 2)
        nutritionNav.tabBarItem = nutritionItem
        
        let pathNav = ForthCoordinator().navigationController
        let pathItem = UITabBarItem(title: "Forth", image: nil, tag: 3)
        pathNav.tabBarItem = pathItem
        
        
        tab.viewControllers = [newsNav,workoutNav,nutritionNav,pathNav]
        
        win.rootViewController = tab
        win.makeKeyAndVisible()
    }
    
}
