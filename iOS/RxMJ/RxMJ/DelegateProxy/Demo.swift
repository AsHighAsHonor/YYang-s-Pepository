//
//  Demo.swift
//  RxMJ
//
//  Created by YYang on 11/11/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation

@objc protocol DemoDelegate: NSObjectProtocol {
    @objc optional func getDemoName(name: String)
    
    @objc optional func similarNumberOfRows(demo: Demo) -> Int
}


class Demo: NSObject {
    weak public var delegate: DemoDelegate?
    
    public func printDemoName() {
        self.delegate?.getDemoName?(name: NSStringFromClass(Demo.self))
        print(delegate?.similarNumberOfRows?(demo: Demo()) as Any)
    }
    
    
}




