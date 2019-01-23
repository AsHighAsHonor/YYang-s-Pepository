//
//  FabricCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit

struct FabricCoordinator {
    let navCtrl: UINavigationController
    
    init(nav: UINavigationController) {
        navCtrl = nav
    }
    
    func start() {
        let f = FabricViewController()
        navCtrl.pushViewController(f, animated: true)
    }
    
    
}
