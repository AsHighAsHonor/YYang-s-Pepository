//
//  FileCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit


class FileCoordinator {
    var navCtrl: UINavigationController
    let vm = FileViewModel()
    let bag = DisposeBag()
    lazy var fabric : FabricCoordinator = {
        let f = FabricCoordinator(nav: self.navCtrl)
        return f
    }()
    init(nav: UINavigationController) {
        navCtrl = nav
    }
    
    func start()  {
        let file = FileViewController()
        file.vm = vm
        vm.output?.subscribe(onNext: {
            print($0)
            self.fabric.start()
        }).disposed(by: bag)
        
        navCtrl.pushViewController(file, animated: true)
    }
    
    
    
    
    
}
