//
//  FirstViewController.swift
//  MyCoordinator
//
//  Created by YYang1 on 23/1/19.
//

import UIKit

class FirstViewController: UIViewController {
    
    var vm: FirstViewModel!
    let bag = DisposeBag()

    @IBOutlet weak var myBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        myBtn.rx.tap
            .bind(to: vm.btnTap)
            .disposed(by: bag)
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
