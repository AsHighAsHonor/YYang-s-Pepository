//
//  ViewController.swift
//  FitTimer
//
//  Created by YYang on 8/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var tabataTimer : TabataTimer = {
        let t = TabataTimer.loadNibView()
        t.configure(round: 5, prepareInterval: 5, workInterval: 10, restInterval: 3)
        view.addSubview(t)
        t.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        })
        return t
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabataTimer.start()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

