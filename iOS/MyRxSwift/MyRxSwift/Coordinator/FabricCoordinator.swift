//
//  FabricCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit

class FabricCoordinator {
    let navCtrl: UINavigationController
    
    
    init(nav: UINavigationController) {
        navCtrl = nav
    }
    
    func start() {
        let fabric = FabricViewController()
        navCtrl.pushViewController(fabric, animated: true)
    }
    
    deinit {
        print("dealloc FabricCoordinator")
    }
    
}
