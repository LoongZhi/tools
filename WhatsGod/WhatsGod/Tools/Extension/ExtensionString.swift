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
    
    public func returnFileType(fileUrl:String) -> String{
        if fileUrl.contains(".") == false {
             return ""
        }
        let typeArr:Array = fileUrl.components(separatedBy: ".")
        if (typeArr.last != nil){
            return typeArr.last!
        }
        return ""
    }
    
    
}
