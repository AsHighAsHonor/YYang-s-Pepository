//
//  MJRefresh+Rx.swift
//  RxMJ
//
//  Created by YYang on 28/10/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation

extension Reactive where Base: MJRefreshComponent{
    
    /// Reactive wrapper for `endRefreshing`
    public var endRefreshing: Binder<Bool>{
        return Binder(base) { (base, isEnd) in
            if isEnd{
                base.endRefreshing()                
            }
        }
    }
    
    /// Reactive wrapper for MJRefresh `refreshingBlock` control event.
    public var beginRefresh: ControlEvent<Void>{
        let refresh: Observable<Void> = Observable.create {[weak control = base] (observable) -> Disposable in
            if let control = control{
                control.refreshingBlock = {
                    observable.onNext(())
                }
            }
            return Disposables.create()
        }

        return ControlEvent(events: refresh)

    }

    
}
