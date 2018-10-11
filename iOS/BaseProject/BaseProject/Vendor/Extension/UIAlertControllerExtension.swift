//
//  UIAlertControllerExtension.swift
//  BaseProject
//
//  Created by YYang1 on 10/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit


public extension UIAlertController{
    

    public static func simpleAlert(title: String?, message: String?, ctrl: UIViewController, yesTitle: String = "Yes", cancelTitle: String = "No", yesHandler: ((UIAlertAction)-> Void)?, cancelHandler:((UIAlertAction)-> Void)?) -> Void {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let act1 = UIAlertAction(title: yesTitle, style: .default, handler: yesHandler)
        let act2 = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
        alert.addAction(act1)
        alert.addAction(act2)
        ctrl.present(alert, animated: true, completion: nil)
    }
    
    public static func alert(title: String?, message: String?, ctrl: UIViewController, actions: [UIAlertAction]) -> Void {
        
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for act in actions {
            alert.addAction(act)
        }
        ctrl.present(alert, animated: true, completion: nil)
    }
    
    
    
    public static func sheet(title: String?, message: String?, ctrl: UIViewController, actions: [UIAlertAction], cancelTitle: String = "No", cancelHandler:((UIAlertAction)-> Void)?) -> Void {

        let alert  = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for act in actions {
            alert.addAction(act)
        }
        let act2 = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
        alert.addAction(act2)
        ctrl.present(alert, animated: true, completion: nil)
    }
    
    public static func textField(title: String?, message: String?, ctrl: UIViewController, yesTitle: String = "Yes", cancelTitle: String = "No", yesHandler: @escaping ((UIAlertAction, UIAlertController)-> Void), cancelHandler:@escaping ((UIAlertAction, UIAlertController)-> Void)) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { aler in
        }
        
        let act1 = UIAlertAction(title: yesTitle, style: .default) { (act) in
            yesHandler(act,alert);
        }
        let act2 = UIAlertAction(title: cancelTitle, style: .cancel){(act) in
            cancelHandler(act,alert);
        }
        alert.addAction(act1)
        alert.addAction(act2)
        ctrl.present(alert, animated: true, completion: nil)
    }
    
    
}
