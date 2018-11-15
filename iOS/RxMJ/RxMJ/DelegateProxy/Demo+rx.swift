//
//  Demo+rx.swift
//  RxMJ
//
//  Created by YYang on 11/11/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


extension Reactive where Base: Demo {
    
    var delegate: DelegateProxy<Demo, DemoDelegate> {
        return RxDemoDelegateProxy.proxy(for: base)
    }
    
    var didPrintName: ControlEvent<String> {
        /**
         DelegateProxy的对象方法 methodInvoked 。
         点到这个方法里，有一大坨的注释解释这个方法。
         大概的意思是说methodInvoked方法只能监听返回值是Void的代理方法。
         有返回值的代理方法要用PublishSubject这个监听，还给了个例子，有兴趣可以点进去看一下。
         */
        let source = self.delegate.methodInvoked(#selector(DemoDelegate.getDemoName(name:))).map({ (a:[Any]) -> String in
            // map函数可以接收到代理方法的参数。可以是单个参数，也可以是多个参数。根据需要取值就可以了，根据参数在代理方法中的位置，下标从0开始。本文实现中，只需要第二个参数，数以取1.
            return a.first as! String
        })
        //  创建event返回
        return ControlEvent(events: source)
    }
    
}




