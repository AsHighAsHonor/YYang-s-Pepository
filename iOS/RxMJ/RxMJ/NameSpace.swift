//
//  NameSpace.swift
//  RxMJ
//
//  Created by YYang on 28/10/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation


public struct Swifty<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}


public extension NSObjectProtocol {
    public var st: Swifty<Self> {
        return Swifty(self)
    }
}


extension Swifty where Base: UITableView {
    public func test() {
        
    }
}
