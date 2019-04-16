//
//  HudManager.swift
//  FitTimer
//
//  Created by YYang1 on 12/9/18.
//  Copyright © 2018 YYang. All rights reserved.
//

import Foundation
import JGProgressHUD
import NVActivityIndicatorView


public class HudManager {
    static let shared = HudManager()
    private init(){}
    
    public lazy var toast : JGProgressHUD = {
        let hud = JGProgressHUD(style: .extraLight)
        return hud
    }()
    
    public lazy var hud : JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        return hud
    }()
    
    public lazy var progressHud : JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        return hud
    }()
    
    fileprivate lazy var kIndicatorTag = 666;
    
    
}

 // MARK: - Toast
extension HudManager{

    public func makeToast(message: String?) {
        toast.indicatorView = nil
        toast.textLabel.text = message
        toast.position = .bottomCenter
        toast.interactionType = .blockTouchesOnHUDView
    }
    
    public func show(view: UIView)  {
        toast.show(in: view)
    }
    
    public func dismiss(delay: Int, animated: Bool = true) {
        toast.dismiss(afterDelay: TimeInterval(delay), animated: animated)
    }
    
    public func showToast(message: String?, in view: UIView, delay: Int = 3) {
        makeToast(message: message)
        show(view: view)
        dismiss(delay: delay)
    }
    
  
}

 // MARK: - HUD
extension HudManager{
    public func showHud(message: String? = nil, in view: UIView, interaction: JGProgressHUDInteractionType = .blockAllTouches) {
        hud.textLabel.text = message
        hud.interactionType = interaction
        hud.show(in: view)
    }
    
    public func hideHud() {
        if hud.isVisible {
            hud.dismiss()
        }
    }
    
    
    public func showRingHud(message: String, in view: UIView, progress: Float? = nil, totalSize: Float? = nil, readedSize: Float? = nil, completed: Bool? = false, detailText: String = "Progress: ", completionTitle: String = "Success!",completionDetail: String = "", interaction: JGProgressHUDInteractionType = .blockAllTouches) {
        progressHud.interactionType = interaction
        var pro: Float = 0
        if let totalSize = totalSize, let readedSize = readedSize {
            pro = readedSize * 1.0 / totalSize;
        }
        
        if let progress = progress{
            pro = progress
        }
        if (readedSize != totalSize || !completed!) {
            progressHud.textLabel.text = message
            let indicator = JGProgressHUDRingIndicatorView(hudStyle: progressHud.style)
            progressHud.indicatorView = indicator
            progressHud.setProgress(pro, animated: false)
            progressHud.detailTextLabel.text = String(format: "\(detailText) %.1f %%", pro * 100)
        } else {
            progressHud.textLabel.text = completionTitle
            progressHud.layoutChangeAnimationDuration = 0.3
            progressHud.indicatorView = JGProgressHUDSuccessIndicatorView()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 1)) {
                self.progressHud.dismiss()
            }
        }
        
        if !progressHud.isVisible {
            progressHud.show(in: view);
        }
        
    }
    
    
    
}

 // MARK: - Indicator
extension HudManager{
    public func showIndicator(in view: UIView, color: UIColor, interaction: Bool, widthScale: CGFloat = 0.15, postionY: CGFloat = SCREEN_HEIGHT/2, type: NVActivityIndicatorType = .ballScaleMultiple) {
        view.isUserInteractionEnabled = interaction
        if let _ = view.viewWithTag(kIndicatorTag) {
            return
        }
        
        let width = SCREEN_WIDTH * widthScale
        let indicator = NVActivityIndicatorView(frame: CGRect(x: (SCREEN_WIDTH - width)/2, y: postionY, width: width, height: width), type: type, color: color, padding: nil)
        indicator.tag = kIndicatorTag
        indicator.tintColor = color
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    public func hideIndicator(view: UIView, delay: Int? = 0) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: delay!)) {
            view.isUserInteractionEnabled = true
            if let indicator = (view.viewWithTag(self.kIndicatorTag) as? NVActivityIndicatorView){
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }

    }

    
}
