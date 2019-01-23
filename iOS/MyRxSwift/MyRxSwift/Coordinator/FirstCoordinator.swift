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
    let vm = FirstViewModel()
    
    lazy var file : FileCoordinator = {
        var f = FileCoordinator(nav: self.navigationController)
        return f
    }()

    init() {
        let first = FirstViewController()
        first.vm = vm
        self.navigationController = UINavigationController(rootViewController: first)
        
        vm.output?.subscribe(onNext: {
            print($0)
            self.file.start()
        }).disposed(by: bag)
    }
    

    
    
    
}
