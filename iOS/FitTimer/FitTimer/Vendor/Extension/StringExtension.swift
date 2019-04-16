//
//  StringExtension.swift
//  FitTimer
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
    static func currentTime(format: String? = "yyyyMMddHHmmssSSS") -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format!
        return dateFormatter.string(from: date)
    }
    
    func secStrToMinSec() -> String{
        let seconds = Int(self)! % 60
        let minutes = (Int(self)! / 60) % 60
        return "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
    
    func toDate(format: String? = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
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


 // MARK: - Attributed String
public extension String{
    public func lineString(remove: Bool? = false, range: NSRange = NSRange(location: 0, length: 0), color: UIColor = UIColor.black, style: NSAttributedString.Key =  .strikethroughStyle) -> NSAttributedString {
        if self.isEmpty {
            return NSMutableAttributedString(string: "")
        }
        
        let str = NSMutableAttributedString(string: self)
        var range1: NSRange!
        if NSEqualRanges(range, NSRange(location: 0, length: 0)) {
            range1 = NSRange(location: 0, length: str.length)
        }else{
            range1 = range
        }
        let number = NSNumber(value:NSUnderlineStyle.single.rawValue)
        str.addAttribute(style, value: number, range: range1)
        str.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range1)
        if remove! {
            str.removeAttribute(style, range: range1)
        }
        
        return str
    }
    
    
    func shadowString(offSet: CGSize? = CGSize.zero, color: UIColor? = .black, radius: CGFloat? = 0.5) -> NSAttributedString {
        let shadow = NSShadow()
        shadow.shadowColor = color!
        shadow.shadowOffset = offSet!
        shadow.shadowBlurRadius = radius!
        let attr = [NSAttributedString.Key.shadow: shadow]
        return NSAttributedString(string: self, attributes: attr)
    }
    
}


public extension String{
    
    static func rounding(number: Double, mode: NSDecimalNumber.RoundingMode, after: Int) -> String {
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: mode, scale: Int16(after), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let ouncesDecimal = NSDecimalNumber(floatLiteral: number)
        let roundedOunces = ouncesDecimal.rounding(accordingToBehavior: roundingBehavior)
        return "\(roundedOunces)"
    }
    
    
    
    
    
}
