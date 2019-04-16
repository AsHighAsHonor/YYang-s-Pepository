//
//  LaunchScreenManager.swift
//  FitTimer
//
//  Created by YYang1 on 12/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import UIKit



class  LaunchScreenManager{
    static let shared = LaunchScreenManager()
    private init(){}
    fileprivate let kScrrenTag = 999

}

extension LaunchScreenManager{
    
    
    public func delayLaunchScreen(delay: Double = 1.0, duraton: Double = 1.0) {
        
        let window = UIApplication.shared.delegate?.window
        var launchView = window??.viewWithTag(kScrrenTag)

        
        if  launchView  == nil {
            let ctrl = UIStoryboard.loadController(ctrlName: "LaunchScreen", storyboard: "LaunchScreen")
            launchView = ctrl.view
            ctrl.view.tag = kScrrenTag
            window??.addSubview(ctrl.view)
            window??.bringSubviewToFront(ctrl.view)
        }

        UIView.animate(withDuration: duraton, delay: delay, options: .curveEaseInOut, animations: {
            launchView?.alpha = 0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }) { final in
            launchView?.removeFromSuperview()
        }


    }

    
}

