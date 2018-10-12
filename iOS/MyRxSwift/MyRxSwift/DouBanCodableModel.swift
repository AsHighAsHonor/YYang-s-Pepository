//
//  DouBanCodableModel.swift
//  MyRxSwift
//
//  Created by YYang1 on 11/10/18.
//  Copyright © 2018 Drag. All rights reserved.
//

import Foundation


class DoubanCodable: Codable {
    let channels : [ChannelCodable]?
}


class ChannelCodable: Codable {
    var nameEn : String?
    var seqId : Int?
    var abbrEn : String?
    var name : String?
    var channelId : Int?

}
