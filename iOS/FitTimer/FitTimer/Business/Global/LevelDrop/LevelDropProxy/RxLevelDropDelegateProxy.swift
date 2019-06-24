//
//  RxLevelDropDelegateProxy.swift
//  
//
//  Created by YYang1 on 13/11/18.
//  
//

import Foundation

class RxLevelDropDelegateProxy: DelegateProxy<LevelDrop, LevelDropDelegate>, DelegateProxyType,  LevelDropDelegate{

    public static func registerKnownImplementations() {
        self.register { RxLevelDropDelegateProxy(parentObject: $0, delegateProxy: RxLevelDropDelegateProxy.self) }
    }
    
    public static func currentDelegate(for object: LevelDrop) -> LevelDropDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: LevelDropDelegate?, to object: LevelDrop) {
        object.delegate = delegate
    }
    
}
