//
//  CellConfigurable.swift
//  
//
//  Created by YYang1 on 28/11/18.
//  
//

import Foundation


typealias LoadConfigurable = NibLoadable & CellConfigurable

protocol CellConfigurable {
    associatedtype Configuration
    
    func configureCell(params: Configuration)
}
