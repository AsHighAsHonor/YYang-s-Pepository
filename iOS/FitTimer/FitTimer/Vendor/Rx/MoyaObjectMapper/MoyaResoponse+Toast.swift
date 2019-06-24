//
//  MoyaResoponse+Toast.swift
//  
//
//  Created by YYang1 on 21/11/18.
//  
//

import Foundation

/*
 ServerErrorCode
 501: Purchase failed
 409: Purchase with same apple account
 406: Can't update future exercises/recipes
 401: Unauthorised
 423: Didn't finish all questions
 426: Subscription expried
 */

public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    func serverMessageToast() -> Single<Response> {
        return self.flatMap { (response) -> Single<Response> in
                if !(200...299 ~= response.statusCode){
//                    NotificationCenter.default.post(name: .IndicatorWillendRefreshNotification, object: nil)
                    self.errorCodeCatcher(response: response)
                    return Single.never()
                }else{
                    return Single.just(response)
                }
            }.catchError({ _ in
//                NotificationCenter.default.post(name: .IndicatorWillendRefreshNotification, object: nil)
                return Single.never()
            })
        
    }
    
    private func errorCodeCatcher(response: Response) {
        guard let rootView = UIApplication.shared.keyWindow?.rootViewController?.view else { return }
        guard let urlStr = response.request?.url?.absoluteString else{ return }
        if response.statusCode == 409{
            HudManager.shared.showToast(message: "Your subscription is currently tied to an existing  account.", in: rootView, delay: 5)
            
        }else if response.statusCode == 406{
            if urlStr.contains("exercise") || urlStr.contains("workout"){
                HudManager.shared.showToast(message: "You can not complete an exercise on a day that's in the future!", in: rootView, delay: 4)
            }else if urlStr.contains("recipe"){// || urlStr.contains("ingredient") || urlStr.contains("complete") || urlStr.contains("duplicate") || urlStr.contains("order_item"){
                HudManager.shared.showToast(message: "You can not have eaten a recipe on a day that's in the future!", in: rootView, delay: 4)
            }
        }else if let error = String(data: response.data, encoding: String.Encoding.utf8){
            let errorModel = ErrorModel(JSONString: error)
            HudManager.shared.showToast(message: errorModel?.error?.joined(separator: ",\n"), in: rootView, delay: 2)
        }
    }
    
    
}

public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response? {
    
    func serverMessageToast() -> Single<Response> {
        return self.flatMap { (response) -> Single<Response> in
            guard let response = response else { return Single.never()}
            
            if !(200...299 ~= response.statusCode){
                if let error = String(data: response.data, encoding: String.Encoding.utf8) {
                    let errorModel = ErrorModel(JSONString: error)
                    let view = (UIApplication.shared.keyWindow?.rootViewController?.view)!
                    HudManager.shared.showToast(message: errorModel?.error?.joined(separator: ",\n"), in: view, delay: 2)
                }
                return Single.never()
            }else{
                return Single.just(response)
            }
            }.catchError({ _ in
                Single.never()
            })
        
    }
    
    
}

extension ObservableType where E == ProgressResponse {
    
    func showProgress(msg: String? = "Uploading...") -> Single<Response?> {
        return self.do(onNext: { (response) in
            let view = (UIApplication.shared.keyWindow?.rootViewController?.view)!
            HudManager.shared.showRingHud(message: msg!, in: view, progress: Float(response.progress), completed: response.completed)
            YYLog("Uploading......\(Float(response.progress))")
        }).flatMap { (response) -> Observable<Response?> in
            return Observable.just(response.response)
            }.asSingle()
        
    }
    
    
}

