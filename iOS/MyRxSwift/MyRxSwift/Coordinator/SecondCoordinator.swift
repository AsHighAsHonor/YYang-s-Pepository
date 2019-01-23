//
//  SecondCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit


struct  SecondCoordinator {
    let navigationController: UINavigationController
    
    init() {
        let second = SecondViewController()
        self.navigationController = UINavigationController(rootViewController: second)
    }
    
    
}
