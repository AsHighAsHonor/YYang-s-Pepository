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
        
        
        myTableView.rx
            .itemSelected.subscribe(onNext: {
                print($0.row)
            }).disposed(by: disposeBag)
        
        myTableView.rx.modelSelected(Channel.self).subscribe(onNext: {
            print($0.name)
        }).disposed(by: disposeBag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView = UIView()
        
        
         // MARK: - DataSource
        let dataObservable = requestJSON(.get, url)
            .map{$1}
            .mapObject(type: Douban.self)
            .map{ $0.channels ?? []}

        
        let items = dataObservable.flatMap { (channel) -> Observable<[SectionModel<String,Channel>]> in
            return Observable.just([SectionModel(model: "section", items: channel)])
        }

        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Channel>>(configureCell: {
            (dataSource, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(indexPath.row)：\(element.name!)"
            return cell
        })
        

         // MARK: - JSONDecoder
//        let dataObservable = requestString(.get, url)
//            .map{$1}
//            .map{ Data($0.utf8) }
//            .flatMap{data -> Observable<[ChannelCodable]>in
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let douban = try decoder.decode(DoubanCodable.self, from: data)
//                print(douban.channels!)
//                return Observable.just(douban.channels!)
//        }
//

        
         // MARK: - BindTo
            myTableView.dataSource = nil
//        dataObservable.bind(to: myTableView.rx.items){ tableView, row , element in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//            cell.textLabel?.text = element.name
//            cell.detailTextLabel?.text = element.nameEn
//            return cell
//        }.disposed(by: disposeBag)
        
        

        //RxDataSources
        items.bind(to: myTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
    
    
    


}
