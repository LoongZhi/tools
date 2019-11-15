//
//  LZDocument.swift
//  WhatsGod
//
//  Created by imac on 11/15/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation
class LZDocument: UIDocument {
    public var data = Data.init()
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        self.data = contents as! Data
    }
}
