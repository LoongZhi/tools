//
//  LZAlbumModel.swift
//  WhatsGod
//
//  Created by imac on 9/25/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation
import RealmSwift
class LZAlbumModel: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var createDate:Double = 0.0
    @objc dynamic var finderName = ""
    @objc dynamic var path = ""
    @objc dynamic var isHidden = true
    @objc dynamic var password = ""
    var images = List<LZAlbumImageModel>()
    override static func primaryKey() ->String?{
        return "id"
    }
    
    
}

class LZAlbumImageModel: Object {
    @objc dynamic var path = ""
    @objc dynamic var imageDes = ""
    @objc dynamic var isHidden = true
    @objc dynamic var isSelect = false
    @objc dynamic var type = ""
    
    
}
