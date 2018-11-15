//
//  RxUIApplicationDelegateProxy.swift
//  RxMJ
//
//  Created by YYang on 11/11/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


public class RxUIApplicationDelegateProxy :
    DelegateProxy<UIApplication, UIApplicationDelegate>,
UIApplicationDelegate, DelegateProxyType {
    
    public weak private(set) var application: UIApplication?
    
    init(application: ParentObject) {
        self.application = application
        super.init(parentObject: application, delegateProxy: RxUIApplicationDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { RxUIApplicationDelegateProxy(application: $0) }
    }
    
    public static func currentDelegate(for object: UIApplication) -> UIApplicationDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: UIApplicationDelegate?,
                                          to object: UIApplication) {
        object.delegate = delegate
    }
    
    override open func setForwardToDelegate(_ forwardToDelegate: UIApplicationDelegate?,
                                            retainDelegate: Bool) {
        super.setForwardToDelegate(forwardToDelegate, retainDelegate: true)
    }
}
