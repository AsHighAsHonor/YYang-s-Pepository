//
//  ErrorModel.swift
//  TheBod
//
//  Created by YYang1 on 21/11/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import Foundation

struct ErrorModel: Mappable {
    var error: [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        error <- map["error"]
    }
    
}
