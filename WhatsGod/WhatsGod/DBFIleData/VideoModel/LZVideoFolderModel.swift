//
//  LZVideoFolderModel.swift
//  WhatsGod
//
//  Created by imac on 10/14/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import RealmSwift
class LZVideoFolderModel: Object {
    
    @objc dynamic var createDate:Double = 0.0
    @objc dynamic var finderName = ""
    @objc dynamic var path = ""
    @objc dynamic var finderPass = false
    @objc dynamic var isHidden = true
    let images = List<LZVideoModel>()
            
}

class LZVideoModel: Object {
    @objc dynamic var path = ""
    @objc dynamic var imageDes = ""
    @objc dynamic var isHidden = true
    @objc dynamic var isSelect = false
    @objc dynamic var imagePath = ""
    
    
}