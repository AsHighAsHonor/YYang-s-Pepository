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
        
        let dataObservable = requestJSON(.get, url)
            .map{$1}
            .mapObject(type: Douban.self)
            .map{ $0.channels ?? []}
        
        
        
        dataObservable.bind(to: myTableView.rx.items){  (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)：\(element.name!)"
            return cell
            }.disposed(by: disposeBag)
        
        
        
    }
    
    
    


}
