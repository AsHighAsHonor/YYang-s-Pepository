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
    func currentTime(format: String = "yyyyMMddHHmmssSSS") -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}



// MARK: - Version Compare
public extension String{
    public func isEqualTo(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedSame
    }
    
    public func isHigherThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedDescending
    }
    
    public func isEqualToOrHigherThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) != .orderedAscending
    }
    
    public func isLowerThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) == .orderedAscending
    }
    
    public func isEqualToOrLowerThan(_ v: String) -> Bool {
        return self.compare(v, options: .numeric, range: nil, locale: nil) != .orderedDescending
    }
    
}


// MARK: - Regular expression
public extension String {
    
    public func validateWithRegExp(regExp: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
        return predicate.evaluate(with: self)
    }
    
    public var isEmailValidate: Bool {
        let regExp_email = "^[a-zA-Z0-9]{1,}@[a-zA-Z0-9]{1,}\\.[a-zA-Z]{2,}$"
        return validateWithRegExp(regExp: regExp_email)
    }
    
    public var isPhoneNumberValidate: Bool {
        let regExp_phoneNumber = "^1\\d{10}$"
        return validateWithRegExp(regExp: regExp_phoneNumber)
    }
    
}

