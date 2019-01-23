//
//  FileViewModel.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import Foundation


struct FileViewModel {
    var btnTap = PublishSubject<Void>()
    
    var output: Observable<String>?
    
    init() {
        output = btnTap.flatMapLatest({ () -> Observable<String> in
            Observable.just("File To Fabric")
        })
    }
}
