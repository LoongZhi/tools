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
    
    @objc dynamic var createDate:Double = 0.0
    @objc dynamic var finderName = ""
    @objc dynamic var finderPass = false
    @objc dynamic var isHidden = true
    let images = List<LZAlbumImageModel>()
    
}

class LZAlbumImageModel: Object {
    
    @objc dynamic var image = Data()
    @objc dynamic var imageDes = ""
    @objc dynamic var isHidden = true
    @objc dynamic var isSelect = false
//    @objc dynamic var ids = ""
    
    
}
