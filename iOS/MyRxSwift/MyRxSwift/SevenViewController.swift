//
//  SevenViewController.swift
//  MyRxSwift
//
//  Created by YYang1 on 26/9/18.
//  Copyright © 2018 Drag. All rights reserved.
//

import UIKit


class SevenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        
        
//        PublishSubject 的订阅者从他们开始订阅的时间点起，可以收到订阅后 Subject 发出的新 Event，而不会收到他们在订阅前已发出的 Event。
//        let pSubject = PublishSubject<String>()
        
//        BehaviorSubject 需要通过一个默认初始值来创建。
//        let bSubject = BehaviorSubject<String>(value: "zzz")
        
//        ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
        let rSubject = ReplaySubject<String>.create(bufferSize: 2)
        
        
//        首先他们都是 Observable，他们的订阅者都能收到他们发出的新的 Event。
//        pSubject.onNext("111")
//        bSubject.onNext("aaa")
        rSubject.onNext("AAA")
        rSubject.onNext("BBB")
        rSubject.onNext("CCC")
        
        //observer1
//        pSubject.subscribe { print($0)}
//            .disposed(by: disposeBag)
        //        当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event。
//        bSubject.subscribe(onNext: {print($0)})
//            .disposed(by: disposeBag)
//        比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个.next 的 event。
        rSubject.subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    
        
//        pSubject.onNext("222")
//        bSubject.onNext("bbb")
        rSubject.onNext("DDD")
        
        //observer2
//        pSubject.subscribe{print($0)}
//            .disposed(by: disposeBag)
//        bSubject.subscribe(onNext: { print($0)})
//            .disposed(by: disposeBag)
        rSubject.subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
//        pSubject.onNext("333")
//        bSubject.onNext("ccc")
        
//        pSubject.onCompleted()
        //BehaviorSubjects  的订阅者不会收到 completed 的事件
//        bSubject.onCompleted()
        rSubject.onCompleted()
        
        //直到 Subject 发出 .complete 或者 .error 的 Event 后，该 Subject 便终结了，同时它也就不会再发出.next事件。
//        pSubject.onNext("444")
//        bSubject.onNext("ddd")
        rSubject.onNext("EEE")

        //对于那些在 Subject 终结后再订阅他的订阅者，也能收到 subject发出的一条 .complete 或 .error的 event，告诉这个新的订阅者它已经终结了。
        //observer3
//        pSubject.subscribe {print($0)}
//            .disposed(by: disposeBag)
        //BehaviorSubjects / ReplaySubjects  的订阅者不会收到 completed 的事件
//        bSubject.subscribe(onNext: {print($0)})
//            .disposed(by: disposeBag)
        rSubject.subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


