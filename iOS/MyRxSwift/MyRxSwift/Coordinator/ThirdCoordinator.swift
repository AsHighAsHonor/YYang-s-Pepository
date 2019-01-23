//
//  ThirdCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit

struct  ThirdCoordinator {
    let navigationController: UINavigationController
    
    init() {
        let third = ThirdViewController()
        self.navigationController = UINavigationController(rootViewController: third)
    }
    
    
}
