//
//  FirstCoordinator.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit


class FirstCoordinator {
    let navigationController: UINavigationController
    let bag = DisposeBag()
    
    

    init() {
        let first = FirstViewController()
        let vm = FirstViewModel()
        first.vm = vm
        self.navigationController = UINavigationController(rootViewController: first)
        
        vm.output?.subscribe(onNext: {
            print($0)
            let f = FileCoordinator(nav: self.navigationController)
            f.start()
        }).disposed(by: bag)
    }
    

    

    deinit {
        print("dealloc FirstCoordinator")
    }
    
    
}
