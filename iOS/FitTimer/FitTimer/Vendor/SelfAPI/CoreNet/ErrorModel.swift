//
//  ErrorModel.swift
//  
//
//  Created by YYang1 on 21/11/18.
//  
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
