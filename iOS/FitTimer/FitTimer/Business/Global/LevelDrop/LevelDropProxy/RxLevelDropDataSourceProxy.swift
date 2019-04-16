//
//  RxLevelDropDataSourceProxy.swift
//  TheBod
//
//  Created by YYang1 on 13/11/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import Foundation


class RxLevelDropDatasourceProxy: DelegateProxy<LevelDrop, LevelDropDatasource>, DelegateProxyType,  LevelDropDatasource{
    
    public static func registerKnownImplementations() {
        self.register { RxLevelDropDatasourceProxy(parentObject: $0, delegateProxy: RxLevelDropDatasourceProxy.self) }
    }
    
    public static func currentDelegate(for object: LevelDrop) -> LevelDropDatasource? {
        return object.dataSource
    }
    
    public static func setCurrentDelegate(_ delegate: LevelDropDatasource?, to object: LevelDrop) {
        object.dataSource = delegate
    }
    
}
