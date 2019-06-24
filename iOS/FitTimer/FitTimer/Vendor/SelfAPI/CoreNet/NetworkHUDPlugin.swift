//
//  NetworkHudPlugin.swift
//  
//
//  Created by YYang on 21/11/18.
//  
//

import Foundation
import Result
import enum Result.Result


/// Network Hud change notification type.
public enum NetworkHudChangeType {
    case began, ended
}

/// Notify a request's network Hud changes (request begins or ends).
struct NetworkHudPlugin: PluginType {
    
    public typealias NetworkHudClosure = (_ change: NetworkHudChangeType, _ target: TargetType, _ message: String? ) -> Void
    let networkHudClosure: NetworkHudClosure
    
    /// Initializes a NetworkHudPlugin.
    public init(networkHudClosure: @escaping NetworkHudClosure) {
        self.networkHudClosure = networkHudClosure
    }
    
    // MARK: Plugin
    
    /// Called by the provider as soon as the request is about to start
    public func willSend(_ request: RequestType, target: TargetType) {
        networkHudClosure(.began, target, nil)
    }
    
//     Called by the provider as soon as a response arrives, even if the request is canceled.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        networkHudClosure(.ended, target, result.error?.errorDescription)
    }
}
