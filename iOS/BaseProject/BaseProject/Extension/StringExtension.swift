//
//  StringExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation

 // MARK: - String Operation
public extension String{
    public func intercept(markString: String)-> String{
        let range: Range = self.range(of: markString)!
        return String(self[range])
    }

}

 // MARK: - Date
public extension String{
    func y_currentTime(format: String = "yyyyMMddHHmmssSSS") -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}



// MARK: - Version Compare
public extension String{
    public func y_isEqualTo(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedSame
    }
    
    public func y_isHigherThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedDescending
    }
    
    public func y_isEqualToOrHigherThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) != .orderedAscending
    }
    
    public func y_isLowerThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedAscending
    }
    
    public func y_isEqualToOrLowerThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) != .orderedDescending
    }
    
}


// MARK: - Regular expression
public extension String {
    
    public func y_validateWithRegExp(regExp: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
        return predicate.evaluate(with: self)
    }
    
    public var y_isEmailValidate: Bool {
        let regExp_email = "^[a-zA-Z0-9]{1,}@[a-zA-Z0-9]{1,}\\.[a-zA-Z]{2,}$"
        return y_validateWithRegExp(regExp: regExp_email)
    }
    
    public var y_isPhoneNumberValidate: Bool {
        let regExp_phoneNumber = "^1\\d{10}$"
        return y_validateWithRegExp(regExp: regExp_phoneNumber)
    }
    
}

