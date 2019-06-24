//
//  ViewPlaceholdable.swift
//  
//
//  Created by YYang1 on 26/2/19.
//  Copyright © 2019 PixelForceSystems. All rights reserved.
//

import UIKit


protocol ViewPlaceholdable {
}

extension ViewPlaceholdable where Self: UIViewController{
    
    func removePlaceholderView() {
        if let container = view.viewWithTag(789){
            container.removeFromSuperview()
        }
        
    }

    
    func addPlaceholderView(placeImageName: String, placeTitle: String? = nil, placeDetail: String? = nil, titlefont: UIFont? = UIFont.systemFont(ofSize: 17), detailfont: UIFont? = UIFont.systemFont(ofSize: 16), textColor: UIColor? = .black, top: CGFloat? = 30, imageSize: CGSize? = CGSize(width: SCREEN_WIDTH * 0.2, height: SCREEN_WIDTH * 0.2)) {
        if view.viewWithTag(789) != nil {
            return
        }
        
        let container = UIView(frame: CGRect(origin:self.view.frame.origin, size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)))
        container.backgroundColor = .clear
        container.tag = 789
        view.insertSubview(container, at: 1)
        let imageView = UIImageView(image: UIImage(named: placeImageName))
        let titleLabel = UILabel()
        titleLabel.text = placeTitle
        titleLabel.font = titlefont!
        titleLabel.textColor = textColor
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        let detailLabel = UILabel()
        detailLabel.text = placeDetail
        detailLabel.font = detailfont!
        detailLabel.textColor = textColor
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center
        
        container.addSubview(titleLabel)
        container.addSubview(detailLabel)
        container.addSubview(imageView)
        imageView.snp.makeConstraints { (maker) in
            maker.size.equalTo(imageSize!)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(TOP_AREA_HEIGHT + top!)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(imageView.snp.bottom).offset(15)

        }
        detailLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
    }
    
}
