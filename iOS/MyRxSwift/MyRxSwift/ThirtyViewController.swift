//
//  ThirtyViewController.swift
//  MyRxSwift
//
//  Created by YYang1 on 27/9/18.
//  Copyright © 2018 Drag. All rights reserved.
//

import UIKit

class ThirtyViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    let disposeBag = DisposeBag()
    let url = URL(string: "https://www.douban.com/j/app/radio/channels")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        requestJSON(.get, url)
//            .map{$1}
//            .mapObject(type: Douban.self)
//            .subscribe(onNext: { (doubanModel) in
//                print((doubanModel.channels?.first?.name)!)
//            }, onError: { (error) in
//                print(error)
//            })
//            .disposed(by: disposeBag)
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView = UIView()
        
//        let dataObservable = requestJSON(.get, url)
//            .map{$1}
//            .mapObject(type: Douban.self)
//            .map{ $0.channels ?? []}
    

        let dataObservable = requestJSON(.get, url).debug()
            .map{$1}
            .map{$0}
            .flatMap{data -> Observable<[ChannelCodable]>in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let douban = try decoder.decode(DoubanCodable.self, from: (data as! Data))
                return Observable.just(douban.channels!)
        }
        
        
        dataObservable.bind(to: myTableView.rx.items){ tableView, row , element in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.nameEn
            return cell
        }.disposed(by: disposeBag)
    
        
//        dataObservable.bind(to: myTableView.rx.items){ tableView, row, element in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//            cell.textLabel?.text = element.name
//            return cell
//            }.disposed(by: disposeBag)
        
    
        
        myTableView.rx
            .itemSelected.subscribe(onNext: {
                print($0.row)
            }).disposed(by: disposeBag)
        
        myTableView.rx.modelSelected(Channel.self).subscribe(onNext: {
            print($0.name)
        }).disposed(by: disposeBag)
        
    }
    
    
    


}
