//
//  UserDefaultExtension.swift
//  
//
//  Created by YYang1 on 21/11/18.
//  
//

import Foundation


protocol UserDefaultNameSpace { }

extension UserDefaultNameSpace {
    static func namespace<T>(_ key:T) -> String where T :RawRepresentable {
        return "\(Self.self).\(key.rawValue) "
    }
}

protocol UserDefaultSettable : UserDefaultNameSpace {
    associatedtype UserDefaultKey : RawRepresentable
}

extension UserDefaultSettable where UserDefaultKey.RawValue == String {}

extension UserDefaultSettable {
    
    static func integer(forKey key:UserDefaultKey) -> Int {
        let key = namespace(key)
        return UserDefaults.standard.integer(forKey: key)
    }
    
    static func set(value:Any?, forKey key:UserDefaultKey){
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func string(forKey key:UserDefaultKey) -> String? {
        let key = namespace(key)
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func bool(forKey key:UserDefaultKey) -> Bool? {
        let key = namespace(key)
        return UserDefaults.standard.bool(forKey: key)
    }
}



