//
//  ViewController.swift
//  BaseProject
//
//  Created by YYang on 8/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        HttpCaller.postAsyn(params: ["email" : "aaa@gmail.com","password" : "12345678"], method: "users/sign-in", success: {
//            print($0)
//        }) {
//            print($0)
//            print($1)
//        }
        
//        HttpCaller.getAsyn(params:nil, method: "branches", success: {
//           print($0)
//        }) {
//           print($0)
//           print($1)
//        }
        
//        HttpCaller.putAsyn(params: nil, method: "", success: {
//            print($0)
//        }) {
//            print($0)
//            print($1)
//        }
        
//        HttpCaller.deleteAsyn(params: nil, method: "cart", success: {
//            print($0)
//        }) {
//            print($0)
//            print($1)
//        }
        
//        YYLog(message: HEX_COLOR(0xff00ff))
//        _ =  UIColor.init(hexString: 0x00000, alpha: 1)
//        _ = UIColor.y_random()`
        YYLog(String.y_currentTime)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

