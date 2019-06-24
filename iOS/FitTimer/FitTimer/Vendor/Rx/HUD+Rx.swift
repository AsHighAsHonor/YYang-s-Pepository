//
//  HUD+Rx.swift
//  
//
//  Created by YYang1 on 15/11/18.
//  
//

import UIKit


extension Reactive where Base: HudManager {
    
    
    /// Reactive wrapper for `showToast`
    public var toast: Binder<(String, Int, UIView)>{
        return Binder(base, binding: { (base,arg1) in
            let (msg, delay, view) = arg1
            Base.shared.showToast(message: msg, in: view, delay: delay)
        })
    }
    
    /// Reactive wrapper for `showHud`
    public var hud: Binder<(String, UIView)>{
        return Binder(base, binding: { (base, arg1) in
            let (msg, view) = arg1
            Base.shared.showHud(message: msg, in: view, interaction: .blockAllTouches)
        })
    }
    
    /// Reactive wrapper for `showRingHud`
    public var ringHud: Binder<(String, UIView, Float, Float, String, String, String)>{
        return Binder(base, binding: { (base, arg1) in
            let (msg, view, totalSize, readedSize, detailText, completionTitle, completionDetail) = arg1
            Base.shared.showRingHud(message: msg, in: view, totalSize: totalSize, readedSize: readedSize, detailText: detailText, completionTitle: completionTitle, completionDetail: completionDetail, interaction: .blockAllTouches)
        })
        
    }
    
    /// Reactive wrapper for `hideHud`
    public var hideHud: Binder<Any>{
        return Binder(base, binding: { (base, arg1) in
            Base.shared.hideHud()
        })
        
    }
    
    

    
    
}
