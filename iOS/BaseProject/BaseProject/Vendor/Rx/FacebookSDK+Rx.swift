//
//  FacebookSDK+Rx.swift
//  TheBod
//
//  Created by YYang1 on 23/11/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import RxSwift
import Foundation
import FacebookCore
import FacebookLogin

enum FacebookSDKError: Error {
    case canceled
}


public extension Reactive where Base: LoginManager {
    public func login(with readPermissions: [ReadPermission], from: UIViewController? = nil) -> Observable<LoginResult> {
        return Observable.create { observer in
            self.base.logIn(readPermissions: readPermissions, viewController: from, completion: { (loginResult) in
                observer.onNext(loginResult)
                observer.on(.completed)
            })
            return Disposables.create()
        }
    }
    
    
    public func login(with publishPermissions: [PublishPermission], from: UIViewController? = nil) -> Observable<LoginResult> {
        return Observable.create { observer in
            self.base.logIn(publishPermissions: publishPermissions, viewController: from, completion: { loginResult in
                if case let .failed(error) = loginResult {
                    observer.onError(error)
                } else {
                    observer.onNext(loginResult)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
}

extension LoginManager: ReactiveCompatible {}




