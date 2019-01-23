//
//  ForthCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit

struct  ForthCoordinator {
    let navigationController: UINavigationController
    
    init() {
        let fourth = ForthViewController()
        self.navigationController = UINavigationController(rootViewController: fourth)
    }
    
    
}
