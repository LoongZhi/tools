//
//  LZOfficeFolderModel.swift
//  WhatsGod
//
//  Created by imac on 10/19/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
import RealmSwift
class LZOfficeFolderModel: Object {
    @objc dynamic var createDate:Double = 0.0
    @objc dynamic var finderName = ""
    @objc dynamic var path = ""
    @objc dynamic var password = ""
    @objc dynamic var isHidden = true
    @objc dynamic var index = 0
    let images = List<LZOfficeModel>()
}

class LZOfficeModel: Object {
    @objc dynamic var path = ""
    @objc dynamic var imageDes = ""
    @objc dynamic var isHidden = true
    @objc dynamic var isSelect = false
    @objc dynamic var imagePath = ""
    @objc dynamic var format = ""
    @objc dynamic var type = ""
}
