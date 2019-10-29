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
        if self.isEmpty || self == nil || self == ""{
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
    
    public func transToHourMinSecs(time: Int) -> String{
        let allTime: Int = Int(time)
        var hours = 0
        var minutes = 0
        var seconds = 0
        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
        hours = allTime / 3600 / 3600
        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        seconds = allTime % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        if hoursText == "0" || hoursText == "00" {
            return "\(minutesText):\(secondsText)"
        }
        return "\(hoursText):\(minutesText):\(secondsText)"
    }
}
