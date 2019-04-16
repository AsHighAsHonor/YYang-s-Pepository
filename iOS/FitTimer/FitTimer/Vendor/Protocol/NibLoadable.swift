//
//  LoadableNibType.swift
//  TheBod
//
//  Created by YYang1 on 19/10/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import UIKit


protocol NibLoadable {
    
    static var loadNib: UINib { get }
    static var reuseId: String { get }

}

extension NibLoadable where Self: UIView{
    
    static func loadNibView() -> Self{
        let nib = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! Self
        return nib
    }
    
    
    static var loadNib: UINib{
        let nib = UINib(nibName: String(describing: self), bundle: nil)
        return nib
    }
    
    static var reuseId: String {
        return String(describing: self)
    }
    
}
