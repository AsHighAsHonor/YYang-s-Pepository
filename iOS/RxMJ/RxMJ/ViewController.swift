//
//  ViewController.swift
//  RxMJ
//
//  Created by YYang on 28/10/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    let demo = Demo()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        
        tableView.tableFooterView = UIView()
        
        //设置头部刷新控件
//        let mjHeader = MJRefreshNormalHeader()
//        let mjFooter = MJRefreshBackNormalFooter()
//        mjHeader.lastUpdatedTimeLabel.isHidden = true
//        mjFooter.stateLabel.isHidden = true
//
//        tableView.mj_header = mjHeader
//        tableView.mj_footer = mjFooter
        tableView.setUpRefreshHeaderAndFooter()
        

        //初始化ViewModel
        let viewModel = ViewModel(
            input: (
                headerRefresh: tableView.mj_header.rx.beginRefresh.asObservable() ,
                footerRefresh: tableView.mj_footer.rx.beginRefresh.asObservable()),
            dependency: (
                disposeBag: self.disposeBag,
                networkService: NetworkService()))
        
        //单元格数据的绑定
        viewModel.tableData
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row+1)、\(element)"
                return cell
            }
            .disposed(by: disposeBag)
        
        //下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .bind(to: self.tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        //上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .bind(to: self.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: disposeBag)

        
        // NameSpaceTest
        tableView.st.test()
        
        
        //DemoDelegateProxyTest
        setUpDemo()
//        demo.name = "This is demo delegate test"
        
        
//        setUpApplication()
        
        
    }




}


extension ViewController{

    func setUpDemo()  {
        
        demo.rx.didPrintName.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)

        demo.printDemoName()

//        demo.rx.didSetName.asObservable().subscribe { (event) in
//            switch event {
//            case .completed:
//                print("completed")
//            case .error(let err):
//                print(err)
//            case .next(let e):
//                print(e)
//            }
//            }.disposed(by: disposeBag)
        
    }
    
    
    func setUpApplication() {
        //应用重新回到活动状态
        UIApplication.shared.rx
            .state
            .subscribe(onNext: { state in
                switch state {
                case .active:
                    print("应用进入活动状态。")
                case .inactive:
                    print("应用进入非活动状态。")
                case .background:
                    print("应用进入到后台。")
                case .terminated:
                    print("应用终止。")
                }
            })
            .disposed(by: disposeBag)
    }
    

    }
    

    


