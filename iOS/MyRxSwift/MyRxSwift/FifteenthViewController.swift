//
//  FifteenthViewController.swift
//  MyRxSwift
//
//  Created by YYang1 on 26/9/18.
//  Copyright © 2018 Drag. All rights reserved.
//

import UIKit
enum MyError: Error {
    case A
    case B
}


class FifteenthViewController: UIViewController {
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let  publish = PublishSubject<String>()
        
//        当遇到 error 事件的时候，就返回指定的值，然后结束。
//        publish.catchErrorJustReturn("This is an error")
//            .subscribe(onNext: {print($0)})
//            .disposed(by: disposeBag)
//

//        该方法可以捕获 error，并对其进行处理。
//        同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）。
//        publish.catchError { (error) -> Observable<String> in
//            print("CatchError:\(error)")
//                return Observable.of("show alert")
//            }
//            .subscribe(onNext: {print($0)})
//            .disposed(by: disposeBag)
//
//        publish.onNext("A")
//        publish.onNext("B")
//        publish.onNext("C")
//        publish.onError(MyError.A)
//        publish.onNext("D")
        
        
        let url = URL(string: "https://www.douban.com/j/app/radio/channels")
        
        request(.get, url!)
            .data()
            .subscribe(onNext: { (data) in
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("返回的数据是：", str ?? "")
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: disposeBag)
     

        
    }
    

}
