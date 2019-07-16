//
//  Configuration.swift
//  TheBod
//
//  Created by YYang1 on 13/6/19.
//  Copyright © 2019 PixelForceSystems. All rights reserved.
//

import Foundation


struct Configurations {
    static var environment: Environment {
        guard let configuration = Bundle.main.infoDictionary?["Configuration"], let config = configuration as? String else{
            return .debug
        }
        if config.lowercased().contains("debug"){
            return .debug
        }
        if config.lowercased().contains("staging"){
            return .staging
        }
        if config.lowercased().contains("release"){
            return .release
        }

        return .debug
    }
    
    
    
}
