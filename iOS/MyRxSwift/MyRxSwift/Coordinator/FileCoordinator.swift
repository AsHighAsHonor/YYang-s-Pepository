//
//  FileCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit


class FileCoordinator {
    var navCtrl: UINavigationController

    let bag = DisposeBag()

    
    init(nav: UINavigationController) {
        navCtrl = nav
    }
    
    func start()  {
        let file = FileViewController()
        let vm = FileViewModel()
        file.vm = vm
        vm.output?.subscribe(onNext: {
            print($0)
            let f = FabricCoordinator(nav: self.navCtrl)
            f.start()
        }).disposed(by: bag)
        
        navCtrl.pushViewController(file, animated: true)
    }
    
    
    deinit {
        print("dealloc FileCoordinator")
    }
    
    
}
