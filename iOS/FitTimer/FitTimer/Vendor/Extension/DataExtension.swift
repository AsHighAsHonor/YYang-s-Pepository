//
//  DataExtension.swift
//  
//
//  Created by YYang1 on 21/11/18.
//  
//

import Foundation


extension Data{
    
    public func toJSONObject() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
    
}
