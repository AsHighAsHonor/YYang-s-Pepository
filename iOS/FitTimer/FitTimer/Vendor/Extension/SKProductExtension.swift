//
//  SKProductExtension.swift
//  
//
//  Created by YYang1 on 5/3/19.
//  Copyright © 2019 PixelForceSystems. All rights reserved.
//

import StoreKit.SKProduct

extension SKProduct {
    var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)
    }
    
    var displayCountryName: String? {
        if let regionCode = priceLocale.regionCode {
            return Locale(identifier: Locale.current.identifier).localizedString(forRegionCode: regionCode)
        }else{
            return nil
        }
    }
}
