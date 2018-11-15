//
//  RxDemoDelegateProxy.swift
//  RxMJ
//
//  Created by YYang on 11/11/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


class RxDemoDelegateProxy: DelegateProxy<Demo, DemoDelegate>, DelegateProxyType, DemoDelegate {
    
    
//    public weak private(set)  var demo: Demo?

    public static func registerKnownImplementations() {
        self.register { RxDemoDelegateProxy(parentObject: $0, delegateProxy: RxDemoDelegateProxy.self) }
    }
    
    public static func currentDelegate(for object: Demo) -> DemoDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: DemoDelegate?, to object: Demo) {
       object.delegate = delegate
    }

    
    
}



