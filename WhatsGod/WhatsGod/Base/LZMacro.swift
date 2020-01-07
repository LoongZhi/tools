//
//  LZMacro.swift
//  WhatsGod
//
//  Created by imac on 9/21/19.
//  Copyright © 2019 L. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
enum FileType {
    case AlbumType
    case VideoType
    case OfficeType
    case WrongType
}
let loadingType = NVActivityIndicatorType.lineScale
//文件类型
func fileUrlType(type:String) -> FileType{
    
    if (maxComparison(type1:type,type2:"jpg") || maxComparison(type1:type,type2:"png") || maxComparison(type1:type,type2:"jpeg") || maxComparison(type1:type,type2:"pic") || maxComparison(type1:type,type2:"gif")){
        return .AlbumType
    }
    if (maxComparison(type1:type,type2:"mp4") || maxComparison(type1:type,type2:"avi") || maxComparison(type1:type,type2:"mpg4") || maxComparison(type1:type,type2:"vfw") || maxComparison(type1:type,type2:"mpg")  || maxComparison(type1:type,type2:"mov") || maxComparison(type1:type,type2:"m3u8")) || maxComparison(type1:type,type2:"3gp") || maxComparison(type1: type, type2: "rmvb") || maxComparison(type1: type, type2: "flv"){
        return .VideoType
    }
    if (maxComparison(type1:type,type2:"xml") || maxComparison(type1:type,type2:"text") || maxComparison(type1:type,type2:"html") || maxComparison(type1:type,type2:"txt") || maxComparison(type1:type,type2:"rtf") || maxComparison(type1:type,type2:"pdf") || maxComparison(type1:type,type2:"doc") || maxComparison(type1:type,type2:"xls") || maxComparison(type1:type,type2:"ppt") || maxComparison(type1:type,type2:"pptx") || maxComparison(type1:type,type2:"wav") || maxComparison(type1:type,type2:"wave") || maxComparison(type1:type,type2:"wvx") || maxComparison(type1:type,type2:"wax") || maxComparison(type1:type,type2:"zip") || maxComparison(type1:type,type2:"tgz") || maxComparison(type1:type,type2:"rar") || maxComparison(type1:type,type2:"docx") || maxComparison(type1:type,type2:"mp3") || maxComparison(type1:type,type2:"mpg3") || maxComparison(type1:type,type2:"ape") || maxComparison(type1:type,type2:"AAC")){
        return .OfficeType
    }
    
    return .WrongType
}
/// 将颜色转换为图片
///
/// - Parameter color: 颜色
/// - Returns: UIImage
func getImageWithColor(color: UIColor) -> UIImage {
    
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
//获取视频截图
func getVideoFengMian(url:URL) -> UIImage {
          if url == nil {
              //默认封面图
              return Img(url: "playBack")
          }
      let type:String = url.absoluteString.returnFileType(fileUrl: url.absoluteString)
       if !maxComparison(type1:type,type2:"mp4") && !maxComparison(type1:type,type2:"3gpp2") && !maxComparison(type1:type,type2:"x-m4v") && !maxComparison(type1:type,type2:"avi") && !maxComparison(type1:type,type2:"3gpp"){
            return Img(url: "playBack")
       }
          let aset = AVURLAsset(url: url, options: nil)
          let assetImg = AVAssetImageGenerator(asset: aset)
          assetImg.appliesPreferredTrackTransform = true
          assetImg.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels
          do{
              let cgimgref = try assetImg.copyCGImage(at: CMTime(seconds: 0, preferredTimescale: 600), actualTime: nil)
              let img = UIImage(cgImage: cgimgref)
              return img
              
          }catch{
               return Img(url: "playBack")
          }
          
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
//图片采样
func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
         
         //生成CGImageSourceRef 时，不需要先解码。
         let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
         let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
         let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
         
         //在创建Thumbnail时直接解码
         let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                  kCGImageSourceShouldCacheImmediately: true,
                                  kCGImageSourceCreateThumbnailWithTransform: true,
                                  kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
         //生成UIImage，强制解码
         let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
         return UIImage(cgImage: downsampledImage)
   }

let VCPassword = "VCPassword"
let languageMark = "languageMark"
//语言本地化
public func LanguageStrins(string:String) ->String{
    LZCustomLanguage.share.lan = UserDefaults.standard.object(forKey: languageMark) as! String
    return LZCustomLanguage.share.showText(key: string)
}
//loding 大小
let lodingSize = CGSize.init(width: 60, height: 60)
//压缩文件路径
let ZIPPATH = "zipfile.zip"
//提示显示时间
let HIDE_DELAY:Double = 1.2
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
