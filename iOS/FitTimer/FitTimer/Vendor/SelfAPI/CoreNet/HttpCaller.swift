//
//  HttpCaller.swift
//  FitTimer
//
//  Created by YYang on 9/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit
import Alamofire




private let SERVER_ADDRESS =  "http://10.0.0.4:3000/api/v1/"//YY
//private let SERVER_ADDRESS =  "https://jsonplaceholder.typicode.com/"//JJ

//private let SERVER_ADDRESS = "https://trader.pixelforcesystems.com.au/api/v1/" // develop
//#define SERVER_ADDRESS @"https://gsme.pixelforcesystems.com.au/api/v1/"  // production



class HttpCaller {
    
    
    
    public class func postAsyn(params: Dictionary<String, String>?, method: String, success: @escaping ((DataResponse<Any>)->Void), failure: @escaping ((DataResponse<Any>,Error)->Void)){
        let url = (SERVER_ADDRESS + method)
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default , headers: httpHeaderFiled()).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response)
            case.failure:
                failure(response,response.error!)
            }
        }
        
    }
    
    public class func getAsyn(params: Dictionary<String, String>?, method: String, success: @escaping ((DataResponse<Any>)->Void), failure: @escaping ((DataResponse<Any>,Error)->Void)){
        let url = (SERVER_ADDRESS + method)
       Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default , headers: httpHeaderFiled()).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response)
            case.failure:
                failure(response,response.error!)
            }
            
        }
        
    }
    
    public class func putAsyn(params: Dictionary<String, String>?, method: String, success: @escaping ((DataResponse<Any>)->Void), failure: @escaping ((DataResponse<Any>,Error)->Void)){
        let url = (SERVER_ADDRESS + method)
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default , headers: httpHeaderFiled()).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response)
            case.failure:
                failure(response,response.error!)
            }
            
        }
    }
    
    public class func putAsynUpload(params: Dictionary<String, String>?, method: String, datas: [Data], names: [String],fileNames: [String], types: [String], progress: @escaping ((Progress)->Void),  success: @escaping ((DataResponse<Any>)->Void), failure: @escaping ((DataResponse<Any>,Error)->Void)){
        let url = (SERVER_ADDRESS + method)
        Alamofire.upload(multipartFormData: { multipartFormData in
            for i in 0..<datas.count{
                var realType = ""
                if types.count == 1{
                    realType = types.first!
                }else{
                    realType = types[i]
                }
                multipartFormData.append(datas[i], withName: names[i], fileName: fileNames[i], mimeType:realType)
            }
            
            }, to: url, method: .put, headers: httpHeaderFiled(), encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                    upload.uploadProgress(closure: progress)
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
        
        
        
    }
    
    public class func deleteAsyn(params: Dictionary<String, String>?, method: String, success: @escaping ((DataResponse<Any>)->Void), failure: @escaping ((DataResponse<Any>,Error)->Void)){
        let url = (SERVER_ADDRESS + method)
        Alamofire.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default , headers: httpHeaderFiled()).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response)
            case.failure:
                failure(response,response.error!)
            }
            
        }
    }
    
    class func patchAsyn(params: Dictionary<String, String>?, method: String, success: @escaping ((DataResponse<Any>)->Void), failure: @escaping ((DataResponse<Any>,Error)->Void)){
        let url = (SERVER_ADDRESS + method)
        Alamofire.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default , headers: httpHeaderFiled()).responseJSON { (response) in
            switch response.result{
            case .success:
                success(response)
            case.failure:
                failure(response,response.error!)
            }
            
        }
    }
    
    
    
    private class func httpHeaderFiled()->HTTPHeaders{
        var headers : HTTPHeaders = [String:String]()
        headers["content-type"] = "application/json"
        headers["X-USER-ID"] = "1"
        headers["X-USER-ACCESS-TOKEN"] = "hpwhiTcn_3RrRou4uyj6"
        return headers;
    }
    


}
