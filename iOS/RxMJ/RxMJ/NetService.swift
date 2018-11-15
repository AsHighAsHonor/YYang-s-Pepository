//
//  NetService.swift
//  RxMJ
//
//  Created by YYang on 28/10/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import RxSwift
import RxCocoa

//网络请求服务
class NetworkService {
    
    //获取随机数据
    func getRandomResult() -> Observable<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map {_ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable
            .delay(2, scheduler: MainScheduler.instance)
    }
    
   
}


