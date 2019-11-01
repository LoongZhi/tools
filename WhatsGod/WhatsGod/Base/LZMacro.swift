//
//  LZMacro.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation

enum FileType {
    case AlbumType
    case VideoType
    case OfficeType
    case WrongType
}
//文件类型
func fileUrlType(type:String) -> FileType{
    
    if (maxComparison(type1:type,type2:"jpg") || maxComparison(type1:type,type2:"png") || maxComparison(type1:type,type2:"jpeg") || maxComparison(type1:type,type2:"pic") || maxComparison(type1:type,type2:"gif")){
        return .AlbumType
    }
    if (maxComparison(type1:type,type2:"mp4") || maxComparison(type1:type,type2:"AVI") || maxComparison(type1:type,type2:"MPG4") || maxComparison(type1:type,type2:"VFW") || maxComparison(type1:type,type2:"MPG")  || maxComparison(type1:type,type2:"mov") || maxComparison(type1:type,type2:"m3u8")) || maxComparison(type1:type,type2:"3gp") {
        return .VideoType
    }
    if (maxComparison(type1:type,type2:"xml") || maxComparison(type1:type,type2:"text") || maxComparison(type1:type,type2:"html") || maxComparison(type1:type,type2:"txt") || maxComparison(type1:type,type2:"rtf") || maxComparison(type1:type,type2:"pdf") || maxComparison(type1:type,type2:"doc") || maxComparison(type1:type,type2:"xls") || maxComparison(type1:type,type2:"ppt") || maxComparison(type1:type,type2:"pptx") || maxComparison(type1:type,type2:"wav") || maxComparison(type1:type,type2:"wave") || maxComparison(type1:type,type2:"wvx") || maxComparison(type1:type,type2:"wax") || maxComparison(type1:type,type2:"zip") || maxComparison(type1:type,type2:"tgz") || maxComparison(type1:type,type2:"rar") || maxComparison(type1:type,type2:"docx") || maxComparison(type1:type,type2:"mp3") || maxComparison(type1:type,type2:"mpg3") || maxComparison(type1:type,type2:"ape") || maxComparison(type1:type,type2:"AAC")){
        return .OfficeType
    }
    
    return .WrongType
}
func modelToJson(model:LZAlbumModel) -> Dictionary<String, Any>{
    var dic:Dictionary<String, Any> = Dictionary<String, Any>.init()
    var arr:NSArray = Array<Dictionary<String, Any>>() as NSArray
    if model.images.count > 0 {
        for subModel in model.images {
            var subDic:Dictionary<String, Any> = Dictionary<String, Any>.init()
            subDic.updateValue(subModel.imageDes, forKey: "imageDes")
            subDic.updateValue(subModel.path, forKey: "path")
            subDic.updateValue(subModel.isHidden, forKey: "isHidden")
            subDic.updateValue(subModel.isSelect, forKey: "isSelect")
            subDic.updateValue(subModel.type, forKey: "type")
            arr.adding(subDic)
        }
    }
    dic.updateValue(model.finderName, forKey: "finderName")
    dic.updateValue(model.path, forKey: "path")
    dic.updateValue(model.createDate, forKey: "createDate")
    dic.updateValue(model.password, forKey: "password")
    dic.updateValue(model.isHidden, forKey: "isHidden")
    dic.updateValue(arr, forKey: "images")
    return dic
}
 func maxComparison(type1:String,type2:String) -> Bool{
    
    if type1.uppercased() == type2.uppercased() {
        return true
    }
    
    return false
}
//数据库对象
 let realm = LZRealmTool.lz_realm

private func blankof<T>(type:T.Type) -> T {
    let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
    let val = ptr.pointee
    ptr.deinitialize(count: 0)
    return val
}
// 获取总内存大小
func totalRAM() -> Double {
    var fs = blankof(type: statfs.self)
    if statfs("/var",&fs) >= 0{
        return Double(Double(fs.f_bsize) * Double(fs.f_blocks))
    }
    return -1
}

// 获取当前可用内存
func availableRAM() -> Double {
    var fs = blankof(type: statfs.self)
    if statfs("/var",&fs) >= 0{
        return Double(Double(fs.f_bsize) * Double(fs.f_bavail))
    }
    return -1
}

//获取UImage
func Img(url:String) -> UIImage{
    return UIImage.init(named: url) ?? UIImage.init()
}
//语言本地化
public func LanguageStrins(string:String) ->String{
    return NSLocalizedString(string, comment: "")
}

//压缩文件路径
let ZIPPATH = "zipfile.zip"
//提示显示时间
let HIDE_DELAY:Double = 2.0
//定义屏幕宽高
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let isPhone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

//判断是否是iPad
let isPad = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)

//判断是否是iPhone X
let isPhoneX = Bool(SCREEN_WIDTH >= 375.0 && SCREEN_HEIGHT >= 812.0 && isPhone)

//导航条的高度
let lzNavigationHeight = CGFloat(isPhoneX ? 88 : 64)

//状态栏高度
let lzkStatusBarHeight = CGFloat(isPhoneX ? 44 : 20)

//tabbar高度
let lzkTabBarHeight = CGFloat(isPhoneX ? (49 + 34) : 49)

//顶部安全区域远离高度
let lzkTopSafeHeight = CGFloat(isPhoneX ? 44 : 0)

//底部安全区域远离高度
let lzBottomSafeHeight = CGFloat(isPhoneX ? 34 : 0)
