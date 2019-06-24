//
//  HttpProvider.swift
//  
//
//  Created by YYang on 20/11/18.
//  
//

import Foundation

    let HttpProvider = MoyaProvider<MultiTarget>(manager: DefaultAlamofireManager.sharedManager, plugins: [networkLoggerPlugin, networkActivityPlugin, networkHudPlugin])

    private let networkLoggerPlugin = NetworkLoggerPlugin(verbose: true)
    
    private let networkActivityPlugin = NetworkActivityPlugin { change, target -> () in
        switch(change){
        case .ended:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        case .began:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
   private let networkHudPlugin = NetworkHudPlugin{ change, target, msg -> Void in
        if let view = UIApplication.currentView(){
            switch (change){
                case .ended:
//                    if let type = (target as? TBTargetCustomizableType), type.delayHud{
//                        HudManager.shared.hideIndicator(view: view, delay: 5)
//                    }else{
//                        HudManager.shared.hideIndicator(view: view)
//                    }
                    if let message = msg{
                        YYLog("Moya Error ================>>>>>> \(message)")
                    }
                case .began:
//                    if let type = (target as? TBTargetCustomizableType), type.needHud{
//                    }
                    HudManager.shared.showIndicator(in: view, color: UIColor.gray, interaction: true)
            }
        }
    }
    
class DefaultAlamofireManager: Alamofire.SessionManager {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
    
