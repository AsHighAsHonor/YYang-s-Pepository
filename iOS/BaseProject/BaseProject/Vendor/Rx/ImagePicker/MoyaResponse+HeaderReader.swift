//
//  MoyaResponse+HeaderReader.swift
//  TheBod
//
//  Created by YYang1 on 20/2/19.
//  Copyright © 2019 PixelForceSystems. All rights reserved.
//

import Foundation


public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    func headerReader() -> Single<Response> {
        return self.flatMap { (response) -> Single<Response> in
                if let httpResponse = response.response {
                    let headers = httpResponse.allHeaderFields
                    var expired: NSString?
                    var strip: NSString?
                    
                    expired = headers["Subscription-Expired"] as? NSString
                    strip = headers["Stripe-Subscription"] as? NSString
                    
                    if expired == nil {
                        expired = headers["subscription-expired"] as? NSString
                    }
                    if strip == nil {
                        strip = headers["stripe-subscription"] as? NSString
                    }
                    
                    
                    if let isExpired = expired?.boolValue {
                        UserDefaults.UserInfo.set(value: isExpired, forKey: .subscriptionExpired)
                    }
                    if let isStrip = strip?.boolValue {
                        UserDefaults.UserInfo.set(value: isStrip, forKey: .stripSubscription)
                    }
                    
                }
                return Single.just(response)
            }.catchError({ _ in
                Single.never()
            })
        
    }
}

    
