//
//  ViewController.swift
//  MyRxSwift
//
//  Created by YYang1 on 25/9/18.
//  Copyright © 2018 Drag. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)

        //将已过去的时间格式化成想要的字符串，并绑定到label上
//        timer.map{ String(format: "%0.2d:%0.2d.%0.1d",
//                          arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10]) }
//            .bind(to: myLabel.rx.text)
//            .disposed(by: disposeBag)
        
        
//        myTextField.rx.text.asObservable()
//            .bind(to: myLabel2.rx.text)
//            .disposed(by: disposeBag)
        
//        myTextField.rx.text.asObservable()
//            .bind{self.myLabel2.text = $0}
//            .disposed(by: disposeBag)
        
        myTextField.rx.text.asObservable()
            .bind(to: myLabel2.rx.text)
            .disposed(by: disposeBag)
        
        
        
//        timer.map{CGFloat(integerLiteral: $0)}
//            .bind(to: myLabel.rx.fontSize)
//            .disposed(by: disposeBag)
        
        
        //        let nf = nestedFunc(name: "aaa")
        //        let value = nf("A","B")
        //        print(value)
        
        
        let  result = nestedFunc(name: "aaa")("A","B")
        print(result)
        
    }
    
    func nestedFunc(name: String) ->(String,String)->Bool {
        print("name is : \(name)")
        
        func innerFunc(firstName:String, lastName: String )->Bool{
            print("first name is : \(firstName), last name is \(lastName)")
            return true
        }
        
        return innerFunc
    }
    



}

extension Reactive where Base: UILabel{
    var fontSize : Binder<CGFloat>{
        return Binder<CGFloat>(self.base){target,value in
            target.font = UIFont.systemFont(ofSize: value)
        }
    
}
    
    


    
    
}

