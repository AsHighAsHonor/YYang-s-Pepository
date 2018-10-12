//
//  FifteenthViewController.swift
//  MyRxSwift
//
//  Created by YYang1 on 26/9/18.
//  Copyright © 2018 Drag. All rights reserved.
//

import UIKit
import Moya


class FifteenthViewController: UIViewController {
    let bag = DisposeBag()

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordTipLabel: UILabel!
    @IBOutlet weak var nameTipLabel: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameObservable = nameTextfield.rx.text.orEmpty.asObservable()
            .map {
                (6 > $0.count && $0.count > 0)
        }
    
        let pwdObservable = passwordTextField.rx.text.orEmpty.asObservable()
            .map {
                (6 > $0.count && $0.count > 0)
        }
        
        nameObservable.bind(to: self.nameTipLabel.rx.isHidden).disposed(by: bag)
        pwdObservable.bind(to: self.passwordTipLabel.rx.isHidden).disposed(by: bag)
        
        
        Observable.combineLatest(nameObservable, pwdObservable) { ($0 && $1) }
            .bind(to: self.loginBtn.rx.isEnabled)
            .disposed(by: bag)
        
        
        loginBtn.rx.tap.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .flatMap {
                Observable.just((self.nameTextfield.text,self.passwordTextField.text))
            }.subscribe(onNext: {
                print($0.0!, $0.1!)
                self.request()
            }).disposed(by: bag)
        
        
        
    }
    
    
    func request() {
        let provider = MoyaProvider<MyApi>()
        provider.request(.Show) { (result) in
            print(result)
        }
        
    }
    
    

}
