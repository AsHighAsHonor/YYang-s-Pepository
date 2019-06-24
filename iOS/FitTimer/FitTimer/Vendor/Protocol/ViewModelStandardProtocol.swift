//
//  ViewModelType.swift
//  
//
//  Created by YYang on 17/11/18.
//  
//

import Foundation

typealias ViewModelPageable = ViewModelable & Pageable

typealias ViewModelPageRefrshable = InputRefreshType & Pageable & OutputRefreshType

typealias ViewModelRefrshable = InputRefreshType & OutputRefreshType


// MARK: - ViewModelType
protocol ViewModelable {
    associatedtype Input
    associatedtype Output
  
    func transform(input: Input) -> Output
}

 // MARK: - PagenationType
protocol Pageable {
    var page: Int{ get  }
}



 // MARK: - Input/OutputType

enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

// Use for input begin refresh event
protocol InputRefreshType {
    var beginRefresh : ControlEvent<Void> { get set }
    var refreshRelay: PublishRelay< Void >{ get }
}

extension InputRefreshType{
    var refreshRelay: PublishRelay< Void >{
        fatalError("Do not use this relay object, implement refreshRelay in yor own ViewModel ")
        return PublishRelay<Void>()
    }
}



// Use for output change control refresh status
protocol OutputRefreshType {
    var refreshStatus : BehaviorRelay<RefreshStatus> { get }
}
extension OutputRefreshType {
    func bindRefreshStatus(header: MJRefreshHeader? = nil, footer: MJRefreshFooter? = nil) -> Disposable {
        return refreshStatus.asObservable().subscribe(onNext: { (status) in
            switch status {
            case .beingHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                footer?.beginRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            case .noMoreData:
                footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
        })
    }
}
