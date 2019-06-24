//
//  UIAlertController+Rx.swift
//  
//
//  Created by YYang1 on 19/12/18.
//  
//

import UIKit

protocol AlertActionType {
    associatedtype Result
    
    var title: String? { get }
    var style: UIAlertAction.Style { get }
    var result: Result { get }
}


struct AlertAction<R>: AlertActionType {
    typealias Result = R
    
    let title: String?
    let style: UIAlertAction.Style
    let result: R
    
    init(actionTitle: String? = nil, actionStyle: UIAlertAction.Style? = .default, actionResult: Result) {
        title = actionTitle
        style = actionStyle!
        result = actionResult
    }
}


extension Reactive where Base: UIAlertController  {
    
    static func presentAlert<Action: AlertActionType, Result>(viewController: UIViewController, title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style? = .alert, animated: Bool? = true, actions: [Action]) -> Observable<Result> where Action.Result == Result {
        
        return Observable.create { observer -> Disposable in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)
            
            actions.map { rxAction in
                    UIAlertAction(title: rxAction.title, style: rxAction.style, handler: { _ in
                        observer.onNext(rxAction.result)
                        observer.onCompleted()
                    })
                }.forEach(alertController.addAction)
            
            viewController.present(alertController, animated: animated!, completion: nil)
            
            return Disposables.create{
                alertController.dismiss(animated: true, completion: nil)
            }
            }.subscribeOn(MainScheduler.instance)
    }
}


