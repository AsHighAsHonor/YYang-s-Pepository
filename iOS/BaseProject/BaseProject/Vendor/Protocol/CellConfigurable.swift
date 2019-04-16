//
//  CellConfigurable.swift
//  TheBod
//
//  Created by YYang1 on 28/11/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import Foundation


typealias LoadConfigurable = NibLoadable & CellConfigurable

protocol CellConfigurable {
    associatedtype Configuration
    
    func configureCell(params: Configuration)
}
