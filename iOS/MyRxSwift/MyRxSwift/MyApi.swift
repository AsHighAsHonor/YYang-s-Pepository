//
//  MyApi.swift
//  MyRxSwift
//
//  Created by YYang1 on 12/10/18.
//  Copyright © 2018 Drag. All rights reserved.
//

import Moya
import UIKit


enum MyApi {
    case Show
    case Create(title: String, body: String, userId: Int)
}

extension MyApi: TargetType {
    var sampleData: Data {
        switch self {
        case .Show:
            return """
                    [{\\"userId\\": \\"1\\", \\"Title\\": \\"Title String\\", \\"Body\\": \\"Body String\\"}]
                    """.data(using: String.Encoding.utf8)!
        case .Create(_, _, _):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
 
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "http://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .Show:
            return "/posts"
        case .Create(_, _, _):
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Show:
            return .get
        case .Create(_, _, _):
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .Show:
            return nil
        case .Create(let title, let body, let userId):
            return ["title": title, "body": body, "userId": userId]
        }
    }

    
    var task: Task {
        switch self {
        case .Show:
            return .requestPlain
        case .Create(let title, let  body, let  userId):
            return .requestParameters(parameters:  ["title": title, "body": body, "userId": userId], encoding:  URLEncoding.default)
        }
    }
}

