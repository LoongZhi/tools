//
//  ExtensionString.swift
//  WhatsGod
//
//  Created by imac on 10/4/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation
extension String {
    
    public func isStringNull() -> Bool{
        if self.isEmpty || self == nil{
            return true
        }
        return false
    }
}
